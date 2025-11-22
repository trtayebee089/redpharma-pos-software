@extends('backend.layout.main') @section('content')
    @if (session()->has('message'))
        <div class="alert alert-success alert-dismissible text-center"><button type="button" class="close"
                data-dismiss="alert" aria-label="Close"><span
                    aria-hidden="true">&times;</span></button>{{ session()->get('message') }}</div>
    @endif
    @if (session()->has('not_permitted'))
        <div class="alert alert-danger alert-dismissible text-center"><button type="button" class="close" data-dismiss="alert"
                aria-label="Close"><span aria-hidden="true">&times;</span></button>{{ session()->get('not_permitted') }}
        </div>
    @endif
    <section class="forms">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header d-flex align-items-center">
                            <h4>{{ __('file.Reward Point Setting') }}</h4>
                        </div>
                        <div class="card-body">
                            <p class="italic">
                                <small>{{ __('file.The field labels marked with * are required input fields') }}.</small>
                            </p>
                            {!! Form::open(['route' => 'setting.rewardPointStore', 'files' => true, 'method' => 'post']) !!}
                            <div class="row">
                                <div class="col-md-3 mt-3">
                                    <div class="form-group">
                                        @if ($lims_reward_point_setting_data && $lims_reward_point_setting_data->is_active)
                                            <input type="checkbox" name="is_active" value="1" checked>
                                        @else
                                            <input type="checkbox" name="is_active" value="1">
                                        @endif &nbsp;
                                        <label>{{ __('file.Active reward point') }}</label>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>{{ __('file.Sold amount per point') }} *</label> <i
                                            class="dripicons-question" data-toggle="tooltip"
                                            title="{{ __('file.This means how much point customer will get according to sold amount. For example, if you put 100 then for every 100 dollar spent customer will get one point as reward.') }}"></i>
                                        <input type="number" name="per_point_amount" class="form-control"
                                            value="@if ($lims_reward_point_setting_data) {{ $lims_reward_point_setting_data->per_point_amount }} @endif"
                                            required />
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>{{ __('file.Minumum sold amount to get point') }} * <i
                                                class="dripicons-question" data-toggle="tooltip"
                                                title="{{ __('file.For example, if you put 100 then customer will only get point after spending 100 dollar or more.') }}"></i></label>
                                        <input type="number" name="minimum_amount" class="form-control"
                                            value="@if ($lims_reward_point_setting_data) {{ $lims_reward_point_setting_data->minimum_amount }} @endif"
                                            required />
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label>{{ __('file.Point Expiry Duration') }}</label>
                                        <input type="number" name="duration" class="form-control"
                                            value="@if ($lims_reward_point_setting_data) {{ $lims_reward_point_setting_data->duration }} @endif" />
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label>{{ __('file.Duration Type') }}</label>
                                        <select name="type" class="form-control">
                                            @if ($lims_reward_point_setting_data && $lims_reward_point_setting_data->type == 'Year')
                                                <option selected value="Year">Years</option>
                                                <option value="Month">Months</option>
                                            @else
                                                <option value="Year">Years</option>
                                                <option selected value="Month">Months</option>
                                            @endif
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-12 form-group">
                                    <button type="submit" class="btn btn-primary">{{ __('file.submit') }}</button>
                                </div>
                            </div>
                            {!! Form::close() !!}
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header d-flex align-items-center justify-content-between">
                            <h4>{{ __('file.Reward Point Tiers') }}</h4>
                            <button class="btn btn-primary" data-toggle="modal"
                                data-target="#createModal">{{ __('file.Add Tier') }}</button>
                        </div>
                        <div class="card-body">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>{{ __('file.Tier Name') }}</th>
                                        <th class="text-center">{{ __('file.Min Points') }}</th>
                                        <th class="text-center">{{ __('file.Max Points') }}</th>
                                        <th class="text-center">{{ __('file.Discount Rate (%)') }}</th>
                                        <th class="text-center">{{ __('file.Deduction Status') }}</th>
                                        <th class="text-center">{{ __('file.Deduction Rule') }}</th>
                                        <th class="text-center">{{ __('file.Actions') }}</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach ($lims_reward_point_tier_data as $tier)
                                        <tr>
                                            <td>{{ $tier->name }}</td>
                                            <td class="text-center">{{ $tier->min_points }}</td>
                                            <td class="text-center">{{ $tier->max_points }}</td>
                                            <td class="text-center">{{ $tier->discount_rate }}%</td>
                                            <td class="text-center">{{ $tier->deduction_enabled == 1 ? 'Enabled' : 'Disabled' }}</td>
                                            <td class="text-center">{{ $tier->deduction_rate_per_unit }} for each <br>{{ $tier->deduction_amount_unit }} Tk</td>
                                            <td class="text-center">
                                                <button class="btn btn-sm btn-primary" data-toggle="modal"
                                                    data-target="#editModal{{ $tier->id }}">
                                                    <i class="fa fa-pencil"></i>
                                                </button>
                                                <!-- Edit Modal -->
                                                <div id="editModal{{ $tier->id }}" class="modal fade" role="dialog">
                                                    <div class="modal-dialog text-left">
                                                        <!-- Modal content-->
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title">{{ __('file.Update Tier') }}</h5>
                                                                <button type="button" class="close"
                                                                    data-dismiss="modal">&times;</button>
                                                            </div>
                                                            <div class="modal-body">
                                                                {!! Form::open(['route' => ['setting.rewardPointTierUpdate', $tier->id], 'method' => 'put']) !!}
                                                                <div class="row">
                                                                    <div class="col-12">
                                                                        <div class="form-group mb-3">
                                                                            <label>{{ __('file.Tier Name') }} *</label>
                                                                            <input type="text" name="name"
                                                                                class="form-control"
                                                                                value="{{ $tier->name }}" required />
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-6">
                                                                        <div class="form-group mb-3">
                                                                            <label>{{ __('file.Min Points') }} *</label>
                                                                            <input type="number" name="min_points"
                                                                                class="form-control"
                                                                                value="{{ $tier->min_points }}"
                                                                                required />
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-6">
                                                                        <div class="form-group mb-3">
                                                                            <label>{{ __('file.Max Points') }} *</label>
                                                                            <input type="number" name="max_points"
                                                                                class="form-control"
                                                                                value="{{ $tier->max_points }}"
                                                                                required />
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-6">
                                                                        <div class="form-group mb-3">
                                                                            <label>{{ __('file.Discount Rate (%)') }}
                                                                                *</label>
                                                                            <input type="number" step="0.01"
                                                                                name="discount_rate" class="form-control"
                                                                                value="{{ $tier->discount_rate }}"
                                                                                required />
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-6">
                                                                        <div class="form-group mb-3">
                                                                            <label>{{ __('file.Discount Enabled') }}
                                                                                *</label>
                                                                            <select name="deduction_enabled"
                                                                                id="deduction_enabled"
                                                                                class="form-control">
                                                                                <option value="0">No</option>
                                                                                <option value="1">Yes</option>
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-6">
                                                                        <div class="form-group mb-3">
                                                                            <label>{{ __('file.Dedcuction Rate Per Amount') }}
                                                                                *</label>
                                                                            <input type="number" step="1"
                                                                                name="deduction_amount_unit"
                                                                                class="form-control" required />
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-6">
                                                                        <div class="form-group mb-3">
                                                                            <label>{{ __('file.Dedcuction Rate Per Unit') }}
                                                                                *</label>
                                                                            <input type="number" step="1"
                                                                                name="deduction_rate_per_unit"
                                                                                class="form-control" required />
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-12">
                                                                        <div class="form-group mb-3">
                                                                            <button type="submit"
                                                                                class="btn btn-primary">{{ __('file.Save Changes') }}</button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                {!! Form::close() !!}
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- End Edit Modal -->
                                                {!! Form::open([
                                                    'route' => ['setting.rewardPointTierDelete', $tier->id],
                                                    'method' => 'delete',
                                                    'class' => 'd-inline',
                                                ]) !!}
                                                <button type="submit" class="btn btn-sm btn-danger"
                                                    onclick="return confirm('Are you sure want to delete this tier?')"><i class="fa fa-trash"></i></button>
                                                {!! Form::close() !!}
                                            </td>
                                        </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div id="createModal" class="modal fade" role="dialog">
            <div class="modal-dialog text-left">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">{{ __('file.Create Tier') }}</h5>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        {!! Form::open(['route' => ['setting.rewardPointTierStore'], 'method' => 'post']) !!}
                        <div class="row">
                            <div class="col-12">
                                <div class="form-group mb-3">
                                    <label>{{ __('file.Tier Name') }} *</label>
                                    <input type="text" name="name" class="form-control" required />
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="form-group mb-3">
                                    <label>{{ __('file.Min Points') }} *</label>
                                    <input type="number" name="min_points" class="form-control" required />
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="form-group mb-3">
                                    <label>{{ __('file.Max Points') }} *</label>
                                    <input type="number" name="max_points" class="form-control" required />
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="form-group mb-3">
                                    <label>{{ __('file.Discount Rate (%)') }} *</label>
                                    <input type="number" step="1" name="discount_rate" class="form-control"
                                        required />
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="form-group mb-3">
                                    <label>{{ __('file.Discount Enabled') }} *</label>
                                    <select name="deduction_enabled" id="deduction_enabled" class="form-control">
                                        <option value="0">No</option>
                                        <option value="1">Yes</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="form-group mb-3">
                                    <label>{{ __('file.Dedcuction Rate Per Amount') }} *</label>
                                    <input type="number" step="1" name="deduction_amount_unit"
                                        class="form-control" required />
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="form-group mb-3">
                                    <label>{{ __('file.Dedcuction Rate Per Unit') }} *</label>
                                    <input type="number" step="1" name="deduction_rate_per_unit"
                                        class="form-control" required />
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="form-group mb-3">
                                    <button type="submit" class="btn btn-primary">{{ __('file.Save Changes') }}</button>
                                </div>
                            </div>
                        </div>
                        {!! Form::close() !!}
                    </div>
                </div>
            </div>
        </div>
    </section>
@endsection

@push('scripts')
    <script type="text/javascript">
        $("ul#setting").siblings('a').attr('aria-expanded', 'true');
        $("ul#setting").addClass("show");
        $("ul#setting #reward-point-setting-menu").addClass("active");

        $('[data-toggle="tooltip"]').tooltip();
    </script>
@endpush
