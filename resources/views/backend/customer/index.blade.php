@extends('backend.layout.main') @section('content')
    @if (session()->has('create_message'))
        <div class="alert alert-success alert-dismissible text-center"><button type="button" class="close"
                data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>{!! session()->get('create_message') !!}
        </div>
    @endif
    @if (session()->has('edit_message'))
        <div class="alert alert-success alert-dismissible text-center"><button type="button" class="close"
                data-dismiss="alert" aria-label="Close"><span
                    aria-hidden="true">&times;</span></button>{{ session()->get('edit_message') }}</div>
    @endif
    @if (session()->has('import_message'))
        <div class="alert alert-success alert-dismissible text-center"><button type="button" class="close"
                data-dismiss="alert" aria-label="Close"><span
                    aria-hidden="true">&times;</span></button>{!! session()->get('import_message') !!}</div>
    @endif
    @if (session()->has('not_permitted'))
        <div class="alert alert-danger alert-dismissible text-center"><button type="button" class="close"
                data-dismiss="alert" aria-label="Close"><span
                    aria-hidden="true">&times;</span></button>{{ session()->get('not_permitted') }}</div>
    @endif

    <section>
        <div class="container-fluid">
            @if (in_array('customers-add', $all_permission))
                <a href="{{ route('customer.create') }}" class="btn btn-info"><i class="dripicons-plus"></i>
                    {{ __('file.Add Customer') }}</a>&nbsp;
                <a href="#" data-toggle="modal" data-target="#importCustomer" class="btn btn-primary"><i
                        class="dripicons-copy"></i> {{ __('file.Import Customer') }}</a>
            @endif
        </div>
        <div class="table-responsive">
            <table id="customer-table" class="table">
                <thead>
                    <tr>
                        <th class="not-exported"></th>
                        <th>{{ __('file.Customer Details') }}</th>
                        <th>{{ __('file.Reward Tiers') }}</th>
                        <th>{{ __('file.Reward Points') }}</th>
                        <th>{{ __('file.Total Due') }}</th>
                        <th>{{ __('file.Delete Request') }}</th>
                        @foreach ($custom_fields as $fieldName)
                            <th>{{ $fieldName }}</th>
                        @endforeach
                        <th class="not-exported">{{ __('file.action') }}</th>
                    </tr>
                </thead>
            </table>
        </div>
    </section>

    <div id="importCustomer" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true"
        class="modal fade text-left">
        <div role="document" class="modal-dialog">
            <div class="modal-content">
                {!! Form::open(['route' => 'customer.import', 'method' => 'post', 'files' => true]) !!}
                <div class="modal-header">
                    <h5 id="exampleModalLabel" class="modal-title">{{ __('file.Import Customer') }}</h5>
                    <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span
                            aria-hidden="true"><i class="dripicons-cross"></i></span></button>
                </div>
                <div class="modal-body">
                    <p class="italic">
                        <small>{{ __('file.The field labels marked with * are required input fields') }}.</small>
                    </p>
                    <p>{{ __('file.The correct column order is') }} (customer_group*, name*, company_name, email,
                        phone_number*, address*, city*, state, postal_code, country)
                        {{ __('file.and you must follow this') }}.</p>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>{{ __('file.Upload CSV File') }} *</label>
                                {{ Form::file('file', ['class' => 'form-control', 'required']) }}
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label> {{ __('file.Sample File') }}</label>
                                <a href="sample_file/sample_customer.csv" class="btn btn-info btn-block btn-md"><i
                                        class="dripicons-download"></i> {{ __('file.Download') }}</a>
                            </div>
                        </div>
                    </div>
                    <input type="submit" value="{{ __('file.submit') }}" class="btn btn-primary" id="submit-button">
                </div>
                {!! Form::close() !!}
            </div>
        </div>
    </div>

    <div id="clearDueModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true"
        class="modal fade text-left">
        <div role="document" class="modal-dialog">
            <div class="modal-content">
                {!! Form::open(['route' => 'customer.clearDue', 'method' => 'post']) !!}
                <div class="modal-header">
                    <h5 id="exampleModalLabel" class="modal-title">{{ __('file.Clear Due') }}</h5>
                    <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span
                            aria-hidden="true"><i class="dripicons-cross"></i></span></button>
                </div>
                <div class="modal-body">
                    <p class="italic">
                        <small>{{ __('file.The field labels marked with * are required input fields') }}.</small>
                    </p>
                    <div class="form-group">
                        <input type="hidden" name="customer_id">
                        <label>{{ __('file.Amount') }} *</label>
                        <input type="number" name="amount" step="any" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>{{ __('file.Note') }}</label>
                        <textarea name="note" rows="4" class="form-control"></textarea>
                    </div>
                    <input type="submit" value="{{ __('file.submit') }}" class="btn btn-primary" id="submit-button">
                </div>
                {!! Form::close() !!}
            </div>
        </div>
    </div>

    <div id="depositModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true"
        class="modal fade text-left">
        <div role="document" class="modal-dialog">
            <div class="modal-content">
                {!! Form::open(['route' => 'customer.addDeposit', 'method' => 'post']) !!}
                <div class="modal-header">
                    <h5 id="exampleModalLabel" class="modal-title">{{ __('file.Add Deposit') }}</h5>
                    <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span
                            aria-hidden="true"><i class="dripicons-cross"></i></span></button>
                </div>
                <div class="modal-body">
                    <p class="italic">
                        <small>{{ __('file.The field labels marked with * are required input fields') }}.</small>
                    </p>
                    <div class="form-group">
                        <input type="hidden" name="customer_id">
                        <label>{{ __('file.Amount') }} *</label>
                        <input type="number" name="amount" step="any" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>{{ __('file.Note') }}</label>
                        <textarea name="note" rows="4" class="form-control"></textarea>
                    </div>
                    <input type="submit" value="{{ __('file.submit') }}" class="btn btn-primary" id="submit-button">
                </div>
                {!! Form::close() !!}
            </div>
        </div>
    </div>

    <div id="view-deposit" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true"
        class="modal fade text-left">
        <div role="document" class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 id="exampleModalLabel" class="modal-title">{{ __('file.All Deposit') }}</h5>
                    <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span
                            aria-hidden="true"><i class="dripicons-cross"></i></span></button>
                </div>
                <div class="modal-body">
                    <table class="table table-hover deposit-list">
                        <thead>
                            <tr>
                                <th>{{ __('file.date') }}</th>
                                <th>{{ __('file.Amount') }}</th>
                                <th>{{ __('file.Note') }}</th>
                                <th>{{ __('file.Created By') }}</th>
                                <th>{{ __('file.action') }}</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <div id="edit-deposit" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true"
        class="modal fade text-left">
        <div role="document" class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 id="exampleModalLabel" class="modal-title">{{ __('file.Update Deposit') }}</h5>
                    <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span
                            aria-hidden="true"><i class="dripicons-cross"></i></span></button>
                </div>
                <div class="modal-body">
                    {!! Form::open(['route' => 'customer.updateDeposit', 'method' => 'post']) !!}
                    <div class="form-group">
                        <label>{{ __('file.Amount') }} *</label>
                        <input type="number" name="amount" step="any" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>{{ __('file.Note') }}</label>
                        <textarea name="note" rows="4" class="form-control"></textarea>
                    </div>
                    <input type="hidden" name="deposit_id">
                    <button type="submit" class="btn btn-primary">{{ __('file.update') }}</button>
                    {{ Form::close() }}
                </div>
            </div>
        </div>
    </div>

    <div id="deleteAccountModal" tabindex="-1" role="modal" class="modal fade"
        aria-labelledby="deleteAccountModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <form id="deleteAccountForm" method="POST" action="{{ route('customer.account-delete') }}">
                    @csrf
                    <input type="hidden" name="customer_id" id="deleteCustomerId">
                    <input type="hidden" name="removal_id" id="deleteRemovalId">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteAccountModalLabel">Confirm Account Deletion</h5>
                        <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span
                                aria-hidden="true"><i class="dripicons-cross"></i></span></button>
                    </div>
                    <div class="modal-body">
                        <p>Please review what will happen when this account is deleted. This action is permanent and cannot
                            be undone.</p>

                        <p>Date Applied: <span id="deleteModalDate"></span></p>

                        <div class="mb-3">
                            <label for="issue" class="form-label">Reason for deletion</label>
                            <select name="issue" id="deleteModalIssue" class="form-select">
                                <option value="I no longer need the service">I no longer need the service</option>
                                <option value="Privacy concerns">Privacy concerns</option>
                                <option value="Found a better alternative">Found a better alternative</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="comment" class="form-label">Additional comments</label>
                            <textarea name="comment" id="deleteModalComment" class="form-control" rows="3"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-danger">Confirm Delete</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
@endsection

@push('scripts')
    <script type="text/javascript">
        $("ul#people").siblings('a').attr('aria-expanded', 'true');
        $("ul#people").addClass("show");
        $("ul#people #customer-list-menu").addClass("active");

        function confirmDelete() {
            if (confirm("Are you sure want to delete?")) {
                return true;
            }
            return false;
        }

        var customer_id = [];
        var user_verified = <?php echo json_encode(env('USER_VERIFIED')); ?>;
        var all_permission = <?php echo json_encode($all_permission); ?>;

        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            }
        });

        $(document).on("click", ".deposit", function() {
            var id = $(this).data('id').toString();
            $("#depositModal input[name='customer_id']").val(id);
        });

        $(document).on("click", ".clear-due", function() {
            var id = $(this).data('id').toString();
            console.log(id);
            $("#clearDueModal input[name='customer_id']").val(id);
        });

        $(document).on("click", ".getDeposit", function() {
            var id = $(this).data('id').toString();
            $.get('customer/getDeposit/' + id, function(data) {
                $(".deposit-list tbody").remove();
                var newBody = $("<tbody>");
                $.each(data[0], function(index) {
                    var newRow = $("<tr>");
                    var cols = '';

                    cols += '<td>' + data[1][index] + '</td>';
                    cols += '<td>' + data[2][index] + '</td>';
                    if (data[3][index])
                        cols += '<td>' + data[3][index] + '</td>';
                    else
                        cols += '<td>N/A</td>';
                    cols += '<td>' + data[4][index] + '<br>' + data[5][index] + '</td>';
                    cols +=
                        '<td><div class="btn-group"><button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">{{ trans('file.action') }}<span class="caret"></span><span class="sr-only">Toggle Dropdown</span></button><ul class="dropdown-menu edit-options dropdown-menu-right dropdown-default" user="menu"><li><button type="button" class="btn btn-link edit-btn" data-id="' +
                        data[0][index] +
                        '" data-toggle="modal" data-target="#edit-deposit"><i class="dripicons-document-edit"></i> {{ trans('file.edit') }}</button></li><li class="divider"></li>{{ Form::open(['route' => 'customer.deleteDeposit', 'method' => 'post']) }}<li><input type="hidden" name="id" value="' +
                        data[0][index] +
                        '" /> <button type="submit" class="btn btn-link" onclick="return confirmDelete()"><i class="dripicons-trash"></i> {{ trans('file.delete') }}</button></li>{{ Form::close() }}</ul></div></td>'
                    newRow.append(cols);
                    newBody.append(newRow);
                    $("table.deposit-list").append(newBody);
                });
                $("#view-deposit").modal('show');
            });
        });

        $(document).on("click", "table.deposit-list .edit-btn", function(event) {
            var id = $(this).data('id');
            var rowindex = $(this).closest('tr').index();
            var amount = $('table.deposit-list tbody tr:nth-child(' + (rowindex + 1) + ')').find('td:nth-child(2)')
                .text();
            var note = $('table.deposit-list tbody tr:nth-child(' + (rowindex + 1) + ')').find('td:nth-child(3)')
                .text();
            if (note == 'N/A')
                note = '';

            $('#edit-deposit input[name="deposit_id"]').val(id);
            $('#edit-deposit input[name="amount"]').val(amount);
            $('#edit-deposit textarea[name="note"]').val(note);
            $('#view-deposit').modal('hide');
        });

        var columns = [{
                data: null,
                defaultContent: '',
                orderable: false,
                className: 'select-checkbox',
                title: '<input type="checkbox" id="select-all">'
            },
            {
                data: 'customer_details',
                title: 'Customer Details'
            },
            {
                data: 'reward_tier',
                title: 'Reward Tier'
            },
            {
                data: 'reward_point',
                title: 'Reward Points'
            },
            {
                data: 'total_due',
                title: 'Total Due'
            },
            {
                data: 'delete_request',
                title: 'Delete Request',
                orderable: false,
                searchable: false
            },
        ];
        var field_name = <?php echo json_encode($field_name); ?>;
        for (i = 0; i < field_name.length; i++) {
            columns.push({
                "data": field_name[i]
            });
        }
        columns.push({
            "data": "options"
        });

        $('#customer-table').DataTable({
            processing: true,
            serverSide: true,
            ajax: {
                url: "customers/customer-data",
                type: "POST",
                data: {
                    all_permission: all_permission
                },
                dataType: "json"
            },
            columns: columns,
            select: {
                style: 'multi',
                selector: 'td:first-child'
            },
            order: [
                [1, 'desc']
            ],
            columnDefs: [{
                targets: 0,
                render: function(data, type, row) {
                    if (type === 'display') {
                        return '<div class="checkbox"><input type="checkbox" class="dt-checkboxes"><label></label></div>';
                    }
                    return data;
                },
                checkboxes: {
                    selectRow: true,
                    selectAllRender: '<div class="checkbox"><input type="checkbox" class="dt-checkboxes"><label></label></div>'
                }
            }],
            lengthMenu: [
                [10, 25, 50, -1],
                [10, 25, 50, "All"]
            ],
            dom: '<"row"lfB>rtip',
            language: {
                lengthMenu: '_MENU_ {{ trans('file.records per page') }}',
                info: '<small>{{ trans('file.Showing') }} _START_ - _END_ (_TOTAL_)</small>',
                search: '{{ trans('file.Search') }}',
                paginate: {
                    previous: '<i class="dripicons-chevron-left"></i>',
                    next: '<i class="dripicons-chevron-right"></i>'
                }
            }
        });

        $('#customer-table').on('click', '.delete-account-btn', function() {
            let customerId = $(this).data('customer-id');
            let removalId = $(this).data('removal-id');

            $.ajax({
                url: "{{ route('customer.get-destroy-request') }}",
                method: "POST",
                data: {
                    customer_id: customerId,
                    removal_id: removalId,
                    _token: '{{ csrf_token() }}'
                },
                success: function(response) {
                    console.log(response)
                    if (response.data) {
                        $('#deleteModalIssue').text(response.data.issue || 'N/A');
                        $('#deleteModalComment').text(response.data.comment || 'N/A');
                        $('#deleteModalDate').text(response.data.created_at);
                        $('#deleteCustomerId').val(response.data.user_id);
                        $('#deleteRemovalId').val(response.data.id);

                        $('#deleteAccountModal').modal('show');
                    }
                },
                error: function(xhr) {
                    alert("Failed to fetch request data.");
                }
            });
        });

        $('#deleteAccountForm').on('submit', function(event) {
            event.preventDefault();

            let formData = $(this).serialize();

            $.ajax({
                url: $(this).attr('action'),
                method: $(this).attr('method') || 'POST',
                data: formData,
                dataType: 'json',
                success: function(response) {
                    alert(response.message || 'Request processed successfully!');
                    $('#deleteAccountForm')[0].reset();
                },
                error: function(xhr) {
                    let message = 'Something went wrong!';
                    if (xhr.responseJSON && xhr.responseJSON.message) {
                        message = xhr.responseJSON.message;
                    } else if (xhr.responseText) {
                        message = xhr.responseText;
                    }
                    alert(message);
                }
            });
        });


        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            }
        });

        if (all_permission.indexOf("customers-delete") == -1)
            $('.buttons-delete').addClass('d-none');
    </script>
@endpush
