@extends('backend.layout.main') @section('content')
    @if (session()->has('message1'))
        <div class="alert alert-success alert-dismissible text-center"><button type="button" class="close"
                data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>{!! session()->get('message1') !!}
        </div>
    @endif
    @if (session()->has('message2'))
        <div class="alert alert-success alert-dismissible text-center"><button type="button" class="close"
                data-dismiss="alert" aria-label="Close"><span
                    aria-hidden="true">&times;</span></button>{{ session()->get('message2') }}</div>
    @endif
    @if (session()->has('message3'))
        <div class="alert alert-danger alert-dismissible text-center"><button type="button" class="close"
                data-dismiss="alert" aria-label="Close"><span
                    aria-hidden="true">&times;</span></button>{{ session()->get('message3') }}</div>
    @endif
    @if (session()->has('not_permitted'))
        <div class="alert alert-danger alert-dismissible text-center"><button type="button" class="close"
                data-dismiss="alert" aria-label="Close"><span
                    aria-hidden="true">&times;</span></button>{{ session()->get('not_permitted') }}</div>
    @endif

    <section>
        @if (in_array('riders-add', $all_permission))
            <div class="container-fluid">
                <button type="button" class="btn btn-info" data-toggle="modal" data-target="#add-rider">
                    <i class="dripicons-plus"></i> {{ __('file.Add Rider') }}
                </button>
            </div>

            <div id="add-rider" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" class="modal fade text-left">
                <div role="document" class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 id="modal-header" class="modal-title">Insert Rider Informations</h5>
                            <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span
                                    aria-hidden="true"><i class="dripicons-cross"></i></span></button>
                        </div>
                        <div class="modal-body">
                            <form action="{{ route('admin.riders.store') }}" method="POST">
                                @csrf
                                <div class="row modal-element">
                                    <div class="col-md-6 form-group">
                                        <label>{{ __('file.Full Name') }}</label>
                                        <input type="text" name="full_name" class="form-control">
                                    </div>
                                    <div class="col-md-6 form-group">
                                        <label>{{ __('file.Phone Number') }}</label>
                                        <input type="text" name="phone" class="form-control">
                                    </div>
                                    <div class="col-md-6 form-group">
                                        <label>{{ __('file.National ID') }}</label>
                                        <input type="text" name="nid" class="form-control">
                                    </div>
                                    <div class="col-md-6 form-group">
                                        <label>{{ __('file.Address') }}</label>
                                        <input type="text" name="address" class="form-control">
                                    </div>
                                    <div class="col-md-6 form-group">
                                        <label>{{ __('file.Emergency Contact') }} (Name - Number)</label>
                                        <input type="text" name="emergency_contact" class="form-control">
                                    </div>
                                </div>
                                <button type="submit" name="update_btn"
                                    class="btn btn-primary">{{ __('file.Save Changes') }}</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        @endif
        <div class="table-responsive">
            <table id="user-table" class="table">
                <thead>
                    <tr>
                        <th class="not-exported"></th>
                        <th>{{ __('file.Full Name') }}</th>
                        <th>{{ __('file.Phone Number') }}</th>
                        <th>{{ __('file.Status') }}</th>
                        <th>{{ __('file.delivery_rate') }}</th>
                        <th class="not-exported">{{ __('file.action') }}</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($lims_user_list as $key => $user)
                        <tr data-id="{{ $user->id }}">
                            <td>{{ $key }}</td>
                            <td>{{ $user->full_name }}</td>
                            <td>{{ $user->phone }}</td>
                            <td>
                                @if ($user->status == 'active')
                                    @if($user->assignedOrders()->whereIn('current_status', ['pending', 'processing', 'in_transit'])->get()->count() > 0)
                                    <div class="badge badge-warning">Assigned</div>
                                    @else
                                    <div class="badge badge-success">Active</div>
                                    @endif
                                @elseif($user->status == 'assigned')
                                    <div class="badge badge-warning">Assigned</div>
                                @else
                                    <div class="badge badge-danger">Inactive</div>
                                @endif
                            </td>
                            <td>
                                @php
                                    $completed = $user->completed_orders ?? 0;
                                    $canceled = $user->canceled_orders ?? 0;
                                    $total = $completed + $canceled;

                                    $deliveryRate = $total > 0 ? round(($completed / $total) * 100, 2) : 0;
                                    $cancellationRate = $total > 0 ? round(($canceled / $total) * 100, 2) : 0;
                                @endphp

                                {{ $deliveryRate }}% ({{ $cancellationRate }}% Cancellation)
                            </td>
                            <td>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-default btn-sm dropdown-toggle"
                                        data-toggle="dropdown" aria-haspopup="true"
                                        aria-expanded="false">{{ __('file.action') }}
                                        <span class="caret"></span>
                                        <span class="sr-only">Toggle Dropdown</span>
                                    </button>
                                    <ul class="dropdown-menu edit-options dropdown-menu-right dropdown-default"
                                        user="menu">
                                        @if (in_array('users-edit', $all_permission))
                                            <li>
                                                <a href="{{ route('user.edit', $user->id) }}" class="btn btn-link"><i
                                                        class="dripicons-document-edit"></i> {{ __('file.edit') }}</a>
                                            </li>
                                        @endif
                                        <li class="divider"></li>
                                        @if (in_array('users-delete', $all_permission))
                                            {{ Form::open(['route' => ['user.destroy', $user->id], 'method' => 'DELETE']) }}
                                            <li>
                                                <button type="submit" class="btn btn-link"
                                                    onclick="return confirmDelete()"><i class="dripicons-trash"></i>
                                                    {{ __('file.delete') }}</button>
                                            </li>
                                            {{ Form::close() }}
                                        @endif
                                    </ul>
                                </div>
                            </td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
    </section>
@endsection

@push('scripts')
    <script type="text/javascript">
        $("ul#people").siblings('a').attr('aria-expanded', 'true');
        $("ul#people").addClass("show");
        $("ul#people #user-list-menu").addClass("active");

        @if (config('database.connections.saleprosaas_landlord'))
            if (localStorage.getItem("message")) {
                alert(localStorage.getItem("message"));
                localStorage.removeItem("message");
            }
            numberOfUserAccount = <?php echo json_encode($numberOfUserAccount); ?>;
            $.ajax({
                type: 'GET',
                async: false,
                url: '{{ route('package.fetchData', $general_setting->package_id) }}',
                success: function(data) {
                    if (data['number_of_user_account'] > 0 && data['number_of_user_account'] <=
                        numberOfUserAccount) {
                        $("a.add-user-btn").addClass('d-none');
                    }
                }
            });
        @endif

        var user_id = [];
        var user_verified = <?php echo json_encode(env('USER_VERIFIED')); ?>;
        var all_permission = <?php echo json_encode($all_permission); ?>;

        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            }
        });

        function confirmDelete() {
            if (confirm("Are you sure want to delete?")) {
                return true;
            }
            return false;
        }

        $('#user-table').DataTable({
            "order": [],
            'language': {
                'lengthMenu': '_MENU_ {{ trans('file.records per page') }}',
                "info": '<small>{{ trans('file.Showing') }} _START_ - _END_ (_TOTAL_)</small>',
                "search": '{{ trans('file.Search') }}',
                'paginate': {
                    'previous': '<i class="dripicons-chevron-left"></i>',
                    'next': '<i class="dripicons-chevron-right"></i>'
                }
            },
            'columnDefs': [{
                    "orderable": false,
                    'targets': [0, 7]
                },
                {
                    'render': function(data, type, row, meta) {
                        if (type === 'display') {
                            data =
                                '<div class="checkbox"><input type="checkbox" class="dt-checkboxes"><label></label></div>';
                        }

                        return data;
                    },
                    'checkboxes': {
                        'selectRow': true,
                        'selectAllRender': '<div class="checkbox"><input type="checkbox" class="dt-checkboxes"><label></label></div>'
                    },
                    'targets': [0]
                }
            ],
            'select': {
                style: 'multi',
                selector: 'td:first-child'
            },
            'lengthMenu': [
                [10, 25, 50, -1],
                [10, 25, 50, "All"]
            ],
            dom: '<"row"lfB>rtip',
            buttons: [{
                    extend: 'excel',
                    text: '<i title="export to excel" class="dripicons-document-new"></i>',
                    exportOptions: {
                        columns: ':visible:Not(.not-exported)',
                        rows: ':visible'
                    },
                },
                {
                    extend: 'csv',
                    text: '<i title="export to csv" class="fa fa-file-text-o"></i>',
                    exportOptions: {
                        columns: ':visible:Not(.not-exported)',
                        rows: ':visible'
                    },
                },
                {
                    extend: 'print',
                    text: '<i title="print" class="fa fa-print"></i>',
                    exportOptions: {
                        columns: ':visible:Not(.not-exported)',
                        rows: ':visible'
                    },
                },
                {
                    extend: 'colvis',
                    text: '<i title="column visibility" class="fa fa-eye"></i>',
                    columns: ':gt(0)'
                },
            ],
        });

        if (all_permission.indexOf("users-delete") == -1)
            $('.buttons-delete').addClass('d-none');
    </script>
@endpush
