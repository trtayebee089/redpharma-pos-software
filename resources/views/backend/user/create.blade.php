@extends('backend.layout.main')

@section('content')

@if(session()->has('not_permitted'))
  <div class="alert alert-danger alert-dismissible text-center">
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
      <span aria-hidden="true">&times;</span>
    </button>
    {{ session()->get('not_permitted') }}
  </div>
@endif

<section class="forms">
  <div class="container-fluid">
    <div class="row">
      <div class="col-md-12">
        <div class="card">
          <div class="card-header d-flex align-items-center">
            <h4>{{ __('file.Add User') }}</h4>
          </div>
          <div class="card-body">
            <p class="italic"><small>{{ __('file.The field labels marked with * are required input fields') }}.</small></p>
            {!! Form::open(['route' => 'user.store', 'method' => 'post', 'files' => true]) !!}
              <div class="row">
                {{-- Left Side --}}
                <div class="col-md-6">
                  <div class="form-group">
                    <label><strong>{{ __('file.UserName') }} *</strong></label>
                    <input type="text" name="name" required class="form-control">
                    @error('name') <small><strong>{{ $message }}</strong></small> @enderror
                  </div>

                  <div class="form-group">
                    <label><strong>{{ __('file.Password') }} *</strong></label>
                    <div class="input-group">
                      <input type="password" name="password" required class="form-control">
                      <div class="input-group-append">
                        <button id="genbutton" type="button" class="btn btn-default">{{ __('file.Generate') }}</button>
                      </div>
                    </div>
                    @error('password') <small><strong>{{ $message }}</strong></small> @enderror
                  </div>

                  <div class="form-group">
                    <label><strong>{{ __('file.Email') }} *</strong></label>
                    <input type="email" name="email" placeholder="example@example.com" required class="form-control">
                    @error('email') <small class="text-danger"><strong>{{ $message }}</strong></small> @enderror
                  </div>

                  <div class="form-group">
                    <label><strong>{{ __('file.Phone Number') }} *</strong></label>
                    <input type="text" name="phone_number" required class="form-control">
                    @error('phone_number') <small><strong>{{ $message }}</strong></small> @enderror
                  </div>

                  <div class="customer-section">
                    <div class="form-group">
                      <label><strong>{{ __('file.Address') }} *</strong></label>
                      <input type="text" name="address" class="form-control customer-input">
                    </div>
                    <div class="form-group">
                      <label><strong>{{ __('file.State') }}</strong></label>
                      <input type="text" name="state" class="form-control">
                    </div>
                    <div class="form-group">
                      <label><strong>{{ __('file.Country') }}</strong></label>
                      <input type="text" name="country" class="form-control">
                    </div>
                  </div>

                  <div class="form-group d-inline-block">
                    <input class="mt-2" type="checkbox" name="is_active" value="1" checked>
                    <label class="mt-2"><strong>{{ __('file.Active') }}</strong></label>
                  </div>

                  @if(in_array('restaurant', explode(',', $general_setting->modules)))
                  <div class="form-group d-inline-block ml-2">
                    <input class="mt-2" type="checkbox" name="service_staff" value="1">
                    <label class="mt-2"><strong>{{ __('file.Waiter') }}</strong></label>
                  </div>
                  @endif

                  <div class="form-group">
                    <input type="submit" value="{{ __('file.submit') }}" class="btn btn-primary">
                  </div>
                </div>

                {{-- Right Side --}}
                <div class="col-md-6">
                  <div class="form-group">
                    <label><strong>{{ __('file.Company Name') }}</strong></label>
                    <input type="text" name="company_name" class="form-control">
                  </div>

                  <div class="form-group">
                    <label><strong>{{ __('file.Role') }} *</strong></label>
                    <select name="role_id" required class="selectpicker form-control" data-live-search="true" data-live-search-style="begins" title="Select Role...">
                      @foreach($lims_role_list as $role)
                        <option value="{{ $role->id }}">{{ $role->name }}</option>
                      @endforeach
                    </select>
                  </div>

                  <div class="customer-section">
                    <div class="form-group">
                      <label><strong>{{ __('file.Customer Group') }} *</strong></label>
                      <select name="customer_group_id" class="selectpicker form-control customer-input" data-live-search="true" data-live-search-style="begins" title="Select customer_group...">
                        @foreach($lims_customer_group_list as $customer_group)
                          <option value="{{ $customer_group->id }}">{{ $customer_group->name }}</option>
                        @endforeach
                      </select>
                    </div>
                    <div class="form-group">
                      <label><strong>{{ __('file.name') }} *</strong></label>
                      <input type="text" name="customer_name" class="form-control customer-input">
                    </div>
                    <div class="form-group">
                      <label><strong>{{ __('file.Tax Number') }}</strong></label>
                      <input type="text" name="tax_number" class="form-control">
                    </div>
                    <div class="form-group">
                      <label><strong>{{ __('file.City') }} *</strong></label>
                      <input type="text" name="city" class="form-control customer-input">
                    </div>
                    <div class="form-group">
                      <label><strong>{{ __('file.Postal Code') }}</strong></label>
                      <input type="text" name="postal_code" class="form-control">
                    </div>
                  </div>

                  <div class="form-group" id="biller-id">
                    <label><strong>{{ __('file.Biller') }} *</strong></label>
                    <select name="biller_id" required class="selectpicker form-control" data-live-search="true" data-live-search-style="begins" title="Select Biller...">
                      @foreach($lims_biller_list as $biller)
                        <option value="{{ $biller->id }}">{{ $biller->name }}</option>
                      @endforeach
                    </select>
                  </div>

                  <div class="form-group" id="supplier-id">
                    <label><strong>{{ __('file.Supplier') }} *</strong></label>
                    <select name="supplier_id" required class="selectpicker form-control" data-live-search="true" data-live-search-style="begins" title="Select Supplier...">
                      @foreach($lims_supplier_list as $supplier)
                        <option value="{{ $supplier->id }}">{{ $supplier->name }}</option>
                      @endforeach
                    </select>
                  </div>

                  <div class="form-group" id="warehouseId">
                    <label><strong>{{ __('file.Warehouse') }} *</strong></label>
                    <select name="warehouse_id" required class="selectpicker form-control" data-live-search="true" data-live-search-style="begins" title="Select Warehouse...">
                      @foreach($lims_warehouse_list as $warehouse)
                        <option value="{{ $warehouse->id }}">{{ $warehouse->name }}</option>
                      @endforeach
                    </select>
                  </div>
                </div>
              </div>
            {!! Form::close() !!}
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

@endsection

@push('scripts')
<script type="text/javascript">
  $("ul#people").siblings('a').attr('aria-expanded', 'true');
  $("ul#people").addClass("show");
  $("ul#people #user-create-menu").addClass("active");

  $('#warehouseId').hide();
  $('#biller-id').hide();
  $('#supplier-id').hide();
  $('.customer-section').hide();

  $('.selectpicker').selectpicker({ style: 'btn-link' });

  @if(config('database.connections.saleprosaas_landlord'))
    let numberOfUserAccount = @json($numberOfUserAccount);
    $.ajax({
      type: 'GET',
      async: false,
      url: '{{ route("package.fetchData", $general_setting->package_id) }}',
      success: function(data) {
        // Example: Check package limits
        // if(data['number_of_user_account'] > 0 && data['number_of_user_account'] <= numberOfUserAccount) {
        //   localStorage.setItem("message", "You don't have permission to create another user account...");
        //   location.href = "{{ route('user.index') }}";
        // }
      }
    });
  @endif

  $('#genbutton').on("click", function() {
    $.get('genpass', function(data) {
      $("input[name='password']").val(data);
    });
  });

  function toggleRoleFields() {
    let roleId = parseInt($('select[name="role_id"]').val());

    if(roleId === 6) { // Supplier
      $('#supplier-id').show(300).find('select').prop('required', true);
      $('#biller-id, #warehouseId').hide(300).find('select').prop('required', false);
      $('.customer-section').hide(300).find('.customer-input').prop('required', false);
    }
    else if(roleId === 5) { // Customer
      $('.customer-section').show(300).find('.customer-input').prop('required', true);
      $('#biller-id, #warehouseId, #supplier-id').hide(300).find('select').prop('required', false);
    }
    else if(roleId > 2 && roleId !== 5) { // Staff
      $('#biller-id, #warehouseId').show(300).find('select').prop('required', true);
      $('#supplier-id').hide(300).find('select').prop('required', false);
      $('.customer-section').hide(300).find('.customer-input').prop('required', false);
    }
    else { // Admin or Others
      $('#biller-id, #warehouseId, #supplier-id').hide(300).find('select').prop('required', false);
      $('.customer-section').hide(300).find('.customer-input').prop('required', false);
    }
  }

  $('select[name="role_id"]').on('change', toggleRoleFields);
  $(document).ready(toggleRoleFields);
</script>
@endpush
