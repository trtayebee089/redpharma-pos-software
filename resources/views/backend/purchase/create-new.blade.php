@extends('backend.layout.main') @section('content')
@if(session()->has('not_permitted'))
  <div class="alert alert-danger alert-dismissible text-center"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>{{ session()->get('not_permitted') }}</div>
@endif
<style>
        .expired-date
        {
            display: none;
        }
         .batch
        {
            display: none;
        }
        td.batch-no {
            display: none;
        }
    @media only screen and (max-width: 768px) {

        .card-body {
            padding: 0.5rem !important;
        }
        .card-header {
            background: 0 0;
            padding: 0.25rem;
            border-bottom: 1px solid #e4e6fc;
        }
        .mt-3, .my-3 {
            margin-top: 0rem !important;
        }
        .product-search {
            display: none !important;
        }
         table.order-list th,
        table.order-list td {
            font-size: 11px;
            padding: 2px 2px;
            white-space: nowrap;
        }

        .table-responsive {
            overflow-x: auto;
        }

        .order-list i {
            font-size: 14px;
        }
        .btn-pos {
            line-height: 19px !important;
            padding: 5px !important;
        }
        .h5, h5 {
            font-size: 12px;
            margin-bottom: 0px !important;
        }
       .subtotal-col > .border {
            text-align: center;
            padding: 2px 0px !important;
            width: 130% !important;
        }
        .subtotal-col{
                margin-right: 10px;
        }

        /* .order-list th:nth-child(5),
        .order-list td:nth-child(5),
        .order-list th:nth-child(6),
        .order-list td:nth-child(6),
        .order-list th:nth-child(8), */
        .batch, .total-discount, .total-tax, .discount, .tax, .expired-date
        /* .order-list td:nth-child(8)  */
        {
            display: none;
        }
        .page, .page.active{
             width: 100% !important;
        }
        .btn {
        font-weight: 400;
        border: 1px solid transparent;
        padding: 7.5px;
        font-size: 11px;
        line-height: 1.5;
        }
        b, strong {
            font-weight: bolder;
            font-size: 12px;
        }
        .subtotal-col{
            width: 100% !important;
            padding-right: 5px !important;
            padding-left: 5px !important;
        }


    }

</style>
<section class="forms">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header d-flex align-items-center">
                        <h4>{{__('file.Add Purchase')}}</h4>
                    </div>
                    <div class="card-body">
                        {!! Form::open(['route' => 'purchases.store', 'method' => 'post', 'files' => true, 'id' => 'purchase-form']) !!}
                         <div class="row">
                            <div class="col-md-12">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label>
                                                {{__('file.Reference No')}}
                                            </label>
                                            <input type="text" name="reference_no" class="form-control" />
                                        </div>
                                        @if($errors->has('reference_no'))
                                       <span>
                                           <strong>{{ $errors->first('reference_no') }}</strong>
                                        </span>
                                        @endif
                                    </div>
                                    @if(Auth::user()->role_id == 1)
                                    @endif
                                    
                                    <input type="hidden" name="supplier_id" id="supplier_id" value="{{Auth::user()->supplier_id}}">
                                    <input type="hidden" name="warehouse_id" id="warehouse_id" value="1">
                                    <input type="hidden" name="status" id="status" value="3">
                                    <input type="hidden" value="{{$currency_list->first()->id}}" name="currency_id"/>
                                    <input type="hidden" value="{{$currency_list->first()->exchange_rate}}" name="exchange_rate"/>
                                    <div class="col-md-12 mt-3">
                                        <label class="product-search">{{__('file.Select Product')}}</label>
                                        <div class="search-box input-group">
                                            <input type="hidden" name="shipping_cost" id="shipping_cost" value="0" class="form-control" step="any" />
                                            <input type="hidden" value="0" id="order_tax_rate" name="order_tax_rate"/>
                                            <button class="btn btn-secondary"><i class="fa fa-barcode"></i></button>
                                            <input type="text" name="product_code_name" id="lims_productcodeSearch" style="border: 2px solid #6244a6;color: #000 !important;" placeholder="Please type product code or name and select..." class="form-control" />

                                        </div>
                                    </div>
                                </div>
                                 <div class="row mt-2">
                                    <div class="col-md-12">
                                        <h5>{{__('file.Order Table')}} *</h5>
                                        <div class="table-responsive mt-0">
                                            <table id="myTable" class="table table-hover order-list">
                                                <thead>
                                                    <tr>
                                                        <th>{{__('file.name')}} & {{__('file.Code')}}</th>
                                                        <th>{{__('file.Quantity')}}</th>
                                                        <th class="recieved-product-qty d-none">{{__('file.Recieved')}}</th>
                                                        <th >{{'Unit cost'}}</th>
                                                        <th class="total-discount">{{__('file.Discount')}}</th>
                                                        <th class="total-tax">{{__('file.Tax')}}</th>
                                                        <th>{{__('file.Total')}}</th>
                                                        <th><i class="dripicons-trash"></i></th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                </tbody>
                                                <tfoot class="tfoot active">
                                                    <th colspan="1">{{__('file.Total')}}</th>
                                                    <th id="total-qty">0</th>
                                                    <th class="recieved-product-qty d-none"></th>
                                                    <th></th>
                                                    <th id="total-discount" class="total-discount">{{number_format(0, $general_setting->decimal, '.', '')}}</th>
                                                    <th id="total-tax" class="total-tax">{{number_format(0, $general_setting->decimal, '.', '')}}</th>
                                                    <th id="total">{{number_format(0, $general_setting->decimal, '.', '')}}</th>
                                                    <th><i class="dripicons-trash"></i></th>
                                                </tfoot>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label>{{__('file.Note')}}</label>
                                             <input type="hidden" name="total_qty"  />
                                            <input type="hidden" name="total_discount" />
                                            <input type="hidden" name="total_tax" />
                                            <input type="hidden" name="total_cost" />
                                            <input type="hidden" name="item" />
                                            <input type="hidden" name="order_tax" />
                                            <input type="hidden" name="grand_total" />
                                            <input type="hidden" name="paid_amount" value="{{number_format(0, $general_setting->decimal, '.', '')}}" />
                                            <input type="hidden" name="payment_status" value="1" />
                                            <input type="hidden" name="order_discount" class="form-control" step="any" />
                                            <textarea rows="1" class="form-control" name="note"></textarea>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <button type="submit" class="btn btn-primary" style="width: 100%;padding: 10px 0px;" id="submit-btn">{{__('file.submit')}}</button>
                                </div>
                            </div>
                        </div>
                        {!! Form::close() !!}
                    </div>
                </div>
            </div>
        </div>
    </div>

<!-- Mobile Grid -->
<div class="container-fluid d-block d-md-none">
    <div class="row">
        <div class="col-2 mb-0.5 subtotal-col">
            <div class="border p-1 rounded bg-light">
                <strong>{{ __('file.Items') }}</strong><br>
                <span class="total-value" id="item">{{ number_format(0, $general_setting->decimal, '.', '') }}</span>
            </div>
        </div>
        <div class="col-2 mb-0.5 subtotal-col">
            <div class="border p-1 rounded bg-light">
                <strong>{{ __('file.Total') }}</strong><br>
                <span class="total-value" id="subtotal">{{ number_format(0, $general_setting->decimal, '.', '') }}</span>
            </div>
        </div>
        <div class="col-2 mb-0.5 subtotal-col">
            <div class="border p-1 rounded bg-light">
                <strong>{{'Tax'}}</strong><br>
                <span class="total-value" id="order_tax">{{ number_format(0, $general_setting->decimal, '.', '') }}</span>
            </div>
        </div>
        <div class="col-2 mb-0.5 subtotal-col">
            <div class="border p-1 rounded bg-light">
                <strong>{{'Discount' }}</strong><br>
                <span class="total-value" id="order_discount">{{ number_format(0, $general_setting->decimal, '.', '') }}</span>
            </div>
        </div>
        <div class="col-2 mb-0.5 subtotal-col">
            <div class="border p-1 rounded bg-light">
                <strong>{{ 'G. Total' }}</strong><br>
                <span class="total-value" id="grand_total">{{ number_format(0, $general_setting->decimal, '.', '') }}</span>
            </div>
        </div>
    </div>
</div>

    <div id="editModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" class="modal fade text-left">
        <div role="document" class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 id="modal-header" class="modal-title"></h5>
                    <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true"><i class="dripicons-cross"></i></span></button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="row modal-element">
                            <div class="col-md-4 form-group">
                                <label>{{__('file.Quantity')}}</label>
                                <input type="number" name="edit_qty" class="form-control" step="any">
                            </div>
                            <div class="col-md-4 form-group">
                                <label>{{__('file.Unit Discount')}}</label>
                                <input type="number" name="edit_discount" class="form-control" step="any">
                            </div>
                            <div class="col-md-4 form-group">
                                <label>{{__('file.Unit Cost')}}</label>
                                <input type="number"   name="edit_unit_cost" class="form-control" step="any">
                            </div>
                            <?php
                                $tax_name_all[] = 'No Tax';
                                $tax_rate_all[] = 0;
                                foreach($lims_tax_list as $tax) {
                                    $tax_name_all[] = $tax->name;
                                    $tax_rate_all[] = $tax->rate;
                                }
                            ?>
                            <div class="col-md-4 form-group">
                                <label>{{__('file.Tax Rate')}}</label>
                                <select name="edit_tax_rate" class="form-control selectpicker">
                                    @foreach($tax_name_all as $key => $name)
                                    <option value="{{$key}}">{{$name}}</option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="col-md-4 form-group">
                                <label>{{__('file.Product Unit')}}</label>
                                <select name="edit_unit" class="form-control selectpicker">
                                </select>
                            </div>
                        </div>
                        <button type="button" name="update_btn"  style="width: 100%;padding: 10px 0px;" class="btn btn-primary">{{__('file.update')}}</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

@endsection
@push('scripts')
<script type="text/javascript">
    // Global variables
    let currentRowIndex = null; // Track the current row being edited

    function generateReferenceNo() {
        let now = new Date();
        let formattedDate = now.getFullYear().toString() +
            String(now.getMonth() + 1).padStart(2, '0') +
            String(now.getDate()).padStart(2, '0');
        let formattedTime = String(now.getHours()).padStart(2, '0') +
            String(now.getMinutes()).padStart(2, '0') +
            String(now.getSeconds()).padStart(2, '0');
        return formattedDate + "-" + formattedTime;
    }

    $(document).ready(function() {
        loadProductsFromLocalStorage();
        document.querySelector('input[name="reference_no"]').value = generateReferenceNo();
    });

    $("ul#purchase").siblings('a').attr('aria-expanded','true');
    $("ul#purchase").addClass("show");
    $("ul#purchase #purchase-create-menu").addClass("active");

    // array data depend on warehouse
    var product_code = [];
    var product_name = [];
    var product_qty = [];

    // array data with selection
    var product_cost = [];
    var product_discount = [];
    var tax_rate = [];
    var tax_name = [];
    var tax_method = [];
    var unit_name = [];
    var unit_operator = [];
    var unit_operation_value = [];
    var is_imei = [];

    // temporary array
    var temp_unit_name = [];
    var temp_unit_operator = [];
    var temp_unit_operation_value = [];

    var customer_group_rate;
    var row_product_cost;
    var currency = <?php echo json_encode($currency) ?>;
    var exchangeRate = 1;
    var currencyChange = false;

    $('#currency-id').val(currency['id']);
    $('.selectpicker').selectpicker({
        style: 'btn-link',
    });

    $('.selectpicker').selectpicker('refresh');

    $('#currency-id').change(function(){
        var rate = $(this).find(':selected').data('rate');
        var currency_id = $(this).val();
        $('#exchange_rate').val(rate);
        exchangeRate = rate;
        currencyChange = true;
        $("table.order-list tbody .qty").each(function(index) {
            checkQuantity($(this).val(), true, index);
        });
    });

    $('[data-toggle="tooltip"]').tooltip();

    $('select[name="status"]').on('change', function() {
        if($('select[name="status"]').val() == 2){
            $(".recieved-product-qty").removeClass("d-none");
            $(".qty").each(function() {
                const rowindex = $(this).closest('tr').index();
                $('table.order-list tbody tr:nth-child(' + (rowindex + 1) + ')').find('.recieved').val($(this).val());
            });

        }
        else if(($('select[name="status"]').val() == 3) || ($('select[name="status"]').val() == 4)) {
            $(".recieved-product-qty").addClass("d-none");
            $(".recieved").each(function() {
                $(this).val(0);
            });
        }
        else {
            $(".recieved-product-qty").addClass("d-none");
            $(".qty").each(function() {
                const rowindex = $(this).closest('tr').index();
                $('table.order-list tbody tr:nth-child(' + (rowindex + 1) + ')').find('.recieved').val($(this).val());
            });
        }
    });

    $('#lims_productcodeSearch').autocomplete({
        source: function(request, response) {
        $.ajax({
                url: "{{ route('product.newSearch') }}",
                type: "Get",
                data: {
                    _token: "{{ csrf_token() }}",
                    term: request.term
                },
                dataType: "json",
                success: function(data) {
                    response(data);
                }
            });

        },
        select: function(event, ui) {
            productSearch(ui.item.value);
        }
    });

    $('body').on('focus',".expired-date", function() {
        $(this).datepicker({
            format: "yyyy-mm-dd",
            startDate: "<?php echo date("Y-m-d", strtotime('+ 1 days')) ?>",
            autoclose: true,
            todayHighlight: true
        });
    });

    //Change quantity
    $("#myTable").on('input', '.qty', function() {
        const rowindex = $(this).closest('tr').index();
        if($(this).val() < 1 && $(this).val() != '') {
            $('table.order-list tbody tr:nth-child(' + (rowindex + 1) + ') .qty').val(1);
            alert("Quantity can't be less than 1");
        }
        checkQuantity($(this).val(), true, rowindex);
    });

    //Delete product
    $("table.order-list tbody").on("click", ".ibtnDel", function(event) {
        const rowindex = $(this).closest('tr').index();
        product_cost.splice(rowindex, 1);
        product_discount.splice(rowindex, 1);
        tax_rate.splice(rowindex, 1);
        tax_name.splice(rowindex, 1);
        tax_method.splice(rowindex, 1);
        unit_name.splice(rowindex, 1);
        unit_operator.splice(rowindex, 1);
        unit_operation_value.splice(rowindex, 1);
        $(this).closest("tr").remove();
        calculateTotal();
        removeProductRowFromLocalStorage(rowindex);
    });

    //Edit product
    $("table.order-list").on("click", ".edit-product", function() {
        currentRowIndex = $(this).closest('tr').index();
        $(".imei-section").remove();

        if(is_imei[currentRowIndex]) {
            var imeiNumbers = $('table.order-list tbody tr:nth-child(' + (currentRowIndex + 1) + ')').find('.imei-number').val();
            if(!imeiNumbers.length) {
                    htmlText = `<div class="col-md-8 form-group imei-section">
                                <label>IMEI or Serial Numbers</label>
                                <div class="table-responsive ml-2">
                                    <table id="imei-table" class="table table-hover">
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <input type="text" class="form-control imei-numbers" name="imei_numbers[]" />
                                                    <input type="text" class="form-control imei-number" name="imei_number[]" />
                                                </td>
                                                <td>
                                                    <button type="button" class="imei-del btn btn-sm btn-danger">X</button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <button type="button" class="btn btn-info btn-sm ml-2 mb-3" id="imei-add-more"><i class="ion-plus"></i> Add More</button>
                            </div>`;
                }
                else {
                    imeiArrays = imeiNumbers.split(",");
                    htmlText = `<div class="col-md-8 form-group imei-section">
                                <label>IMEI or Serial Numbers</label>
                                <div class="table-responsive ml-2">
                                    <table id="imei-table" class="table table-hover">
                                        <tbody>`;
                    for (var i = 0; i < imeiArrays.length; i++) {
                        htmlText += `<tr>
                                        <td>
                                            <input type="text" class="form-control imei-numbers" name="imei_numbers[]" value="`+imeiArrays[i]+`" />
                                            <input type="text" class="form-control imei-number" name="imei_number[]" value="`+imeiArrays[i]+`" />
                                        </td>
                                        <td>
                                            <button type="button" class="imei-del btn btn-sm btn-danger">X</button>
                                        </td>
                                    </tr>`;
                    }
                    htmlText += `</tbody>
                                    </table>
                                </div>
                                <button type="button" class="btn btn-info btn-sm ml-2 mb-3" id="imei-add-more"><i class="ion-plus"></i> Add More</button>
                            </div>`;
                }
            $("#editModal .modal-element").append(htmlText);
        }

        let purchase_products = JSON.parse(localStorage.getItem('purchase_products')) || [];
        const product = purchase_products[currentRowIndex];
        console.log(product.unit_cost);
        $('button[name="update_btn"]').data('index', currentRowIndex);
        $('input[name="edit_qty"]').val(product.qty || 1);
        $('input[name="edit_discount"]').val(parseFloat(product.product_discount || 0));
        $('input[name="edit_unit_cost"]').val(product.unit_cost || 0);
        // $('input[name="edit_unit_cost"]').val(parseFloat(product.edit_unit_cost || 0));

        $('select[name="edit_tax_rate"]').val(product.tax_rate);
        $('select[name="edit_unit"]').html(`<option selected>${product.purchase_unit}</option>`);
        $('.selectpicker').selectpicker('refresh');

        var row_product_name = $('table.order-list tbody tr:nth-child(' + (currentRowIndex + 1) + ')').find('td:nth-child(1)').text();
        var row_product_code = $('table.order-list tbody tr:nth-child(' + (currentRowIndex + 1) + ')').find('td:nth-child(2)').text();
        $('#modal-header').text(row_product_name + '(' + row_product_code + ')');

        var qty = $(this).closest('tr').find('.qty').val();
        $('input[name="edit_qty"]').val(qty);

        $('input[name="edit_discount"]').val(parseFloat(product_discount[currentRowIndex]).toFixed({{$general_setting->decimal}}));

        unitConversion(currentRowIndex);
        $('input[name="edit_unit_cost"]').val(parseFloat(product.unit_cost).toFixed({{$general_setting->decimal}}));

        var tax_name_all = <?php echo json_encode($tax_name_all) ?>;
        var pos = tax_name_all.indexOf(tax_name[currentRowIndex]);
        $('select[name="edit_tax_rate"]').val(pos);

        temp_unit_name = (unit_name[currentRowIndex]).split(',');
        temp_unit_name.pop();
        temp_unit_operator = (unit_operator[currentRowIndex]).split(',');
        temp_unit_operator.pop();
        temp_unit_operation_value = (unit_operation_value[currentRowIndex]).split(',');
        temp_unit_operation_value.pop();
        $('select[name="edit_unit"]').empty();
        $.each(temp_unit_name, function(key, value) {
            $('select[name="edit_unit"]').append('<option value="' + key + '">' + value + '</option>');
        });
        $('.selectpicker').selectpicker('refresh');
    });

    //add imei
    $(document).on("click", "#imei-add-more", function() {
        var newRow = $("<tr>");
        var cols = '';
        cols += '<td><input type="text" class="form-control imei-numbers" name="imei_numbers[]" /></td>';
        cols += '<td><input type="text" class="form-control imei-number"  name="imei_number[]" /></td>';
        cols += '<td><button type="button" class="imei-del btn btn-sm btn-danger">X</button></td>';
        newRow.append(cols);
        $("table#imei-table tbody").append(newRow);
        var edit_qty = parseFloat($('input[name="edit_qty"]').val());
        $('input[name="edit_qty"]').val(edit_qty+1);
    });

    //Delete imei
    $(document).on("click", "table#imei-table tbody .imei-del", function() {
        $(this).closest("tr").remove();
        var edit_qty = parseFloat($('input[name="edit_qty"]').val());
        $('input[name="edit_qty"]').val(edit_qty-1);
    });

    // $('button[name="update_btn"]').on('click', function () {
    //     if (currentRowIndex === null) {
    //         alert("No row selected for editing!");
    //         return;
    //     }

    //     let purchase_products = JSON.parse(localStorage.getItem('purchase_products')) || [];

    //     if (!purchase_products[currentRowIndex]) {
    //         alert("Invalid row selected!");
    //         return;
    //     }

    //     // Input values
    //     const qty = parseFloat($('input[name="edit_qty"]').val()) || 1;
    //     const discount = parseFloat($('input[name="edit_discount"]').val()) || 0;
    //     const unit_cost = parseFloat($('input[name="edit_unit_cost"]').val()) || 0;
    //     const tax_rate = parseFloat($('select[name="edit_tax_rate"]').val()) || 0;
    //     const unit = $('select[name="edit_unit"]').val() || '';

    //     // Calculation
    //     const net_unit_cost = (unit_cost - discount);
    //     const subtotal = qty * net_unit_cost;
    //     //   const subtotal = qty * unit_cost;
    //     const tax_value = (subtotal * tax_rate) / 100;
    //     const total = subtotal + tax_value;


    //     // Update product in localStorage
    //     purchase_products[currentRowIndex].qty = qty;
    //     purchase_products[currentRowIndex].discount = parseFloat(discount * qty).toFixed({{$general_setting->decimal}});
    //     purchase_products[currentRowIndex].product_discount = parseFloat(discount).toFixed({{$general_setting->decimal}});
    //     purchase_products[currentRowIndex].tax_rate = tax_rate.toFixed({{$general_setting->decimal}});
    //     purchase_products[currentRowIndex].tax_value = tax_value.toFixed({{$general_setting->decimal}});
    //     purchase_products[currentRowIndex].unit_cost = unit_cost.toFixed({{$general_setting->decimal}});
    //     purchase_products[currentRowIndex].net_unit_cost = (unit_cost - discount).toFixed({{$general_setting->decimal}});
    //     purchase_products[currentRowIndex].subtotal = subtotal.toFixed({{$general_setting->decimal}});
    //     purchase_products[currentRowIndex].total = total.toFixed({{$general_setting->decimal}});
    //     purchase_products[currentRowIndex].unit = unit;

    //     // Update arrays
    //     product_cost[currentRowIndex] = unit_cost;
    //     product_discount[currentRowIndex] = discount;
    //     tax_rate[currentRowIndex] = tax_rate;

    //     // Save back to localStorage
    //     localStorage.setItem('purchase_products', JSON.stringify(purchase_products));

    //     // Update the table row
    //     const $row = $('table.order-list tbody tr').eq(currentRowIndex);
    //     $row.find('.qty').val(qty);
    //     $row.find('.net_unit_cost').text(unit_cost.toFixed(2));
    //     $row.find('.discount').text((discount * qty).toFixed(2));
    //     $row.find('.discount-value').val((discount * qty).toFixed(2));
    //     $row.find('.tax').text(tax_value.toFixed(2));
    //     $row.find('.tax-value').val(tax_value.toFixed(2));
    //     $row.find('.sub-total').text(total.toFixed(2));
    //     $row.find('.subtotal-value').val(total.toFixed(2));
    //     $row.find('.tax-rate').val(tax_rate);
    //     $row.find('.net_unit_cost').val(unit_cost);
    //     $row.find('.purchase-unit').val(unit);

    //     // Reload product table
    //     loadProductsFromLocalStorage();

    //     // Hide modal
    //     $('#editModal').modal('hide');
    //     currentRowIndex = null;
    // });
    $('button[name="update_btn"]').on('click', function () {
        if (currentRowIndex === null) {
            alert("No row selected for editing!");
            return;
        }

        let purchase_products = JSON.parse(localStorage.getItem('purchase_products')) || [];

        if (!purchase_products[currentRowIndex]) {
            alert("Invalid row selected!");
            return;
        }

        // Input values
        const qty = parseFloat($('input[name="edit_qty"]').val()) || 1;
        const discount = parseFloat($('input[name="edit_discount"]').val()) || 0;
        const unit_cost = parseFloat($('input[name="edit_unit_cost"]').val()) || 0;
        const tax_rate = parseFloat($('select[name="edit_tax_rate"]').val()) || 0;
        const unit = $('select[name="edit_unit"]').val() || '';
        const edit_unit_cost = parseFloat($('input[name="edit_unit_cost"]').val()) || 0;


        // Calculate net unit cost (Unit Cost - Unit Discount)
        const net_unit_cost = unit_cost - discount;
        // Calculation - use NET unit cost for calculations
        const subtotal = qty * net_unit_cost;
        const tax_value = (subtotal * tax_rate) / 100;
        const total = subtotal + tax_value;

        // Update product in localStorage
        purchase_products[currentRowIndex].qty = qty;
        purchase_products[currentRowIndex].discount = parseFloat(discount * qty).toFixed({{$general_setting->decimal}});
        purchase_products[currentRowIndex].product_discount = parseFloat(discount).toFixed({{$general_setting->decimal}});
        purchase_products[currentRowIndex].tax_rate = tax_rate.toFixed({{$general_setting->decimal}});
        purchase_products[currentRowIndex].tax_value = tax_value.toFixed({{$general_setting->decimal}});
        purchase_products[currentRowIndex].unit_cost = unit_cost.toFixed({{$general_setting->decimal}});
        purchase_products[currentRowIndex].net_unit_cost = net_unit_cost.toFixed({{$general_setting->decimal}});
        purchase_products[currentRowIndex].subtotal = subtotal.toFixed({{$general_setting->decimal}});
         purchase_products[currentRowIndex].edit_unit_cost = edit_unit_cost.toFixed({{$general_setting->decimal}});
        purchase_products[currentRowIndex].total = total.toFixed({{$general_setting->decimal}});
        purchase_products[currentRowIndex].unit = unit;

        // Update arrays
        product_cost[currentRowIndex] = unit_cost;
        product_discount[currentRowIndex] = discount;
        tax_rate[currentRowIndex] = tax_rate;

        // Save back to localStorage
        localStorage.setItem('purchase_products', JSON.stringify(purchase_products));

        // Update the table row - show NET unit cost in the display
        const $row = $('table.order-list tbody tr').eq(currentRowIndex);
        $row.find('.qty').val(qty);
        $row.find('.net_unit_cost').text(net_unit_cost.toFixed(2)); // Show NET unit cost
        $row.find('.discount').text((discount * qty).toFixed(2));
        $row.find('.discount-value').val((discount * qty).toFixed(2));
        $row.find('.tax').text(tax_value.toFixed(2));
        $row.find('.tax-value').val(tax_value.toFixed(2));
        $row.find('.sub-total').text(total.toFixed(2));
        $row.find('.subtotal-value').val(total.toFixed(2));
        $row.find('.tax-rate').val(tax_rate);
        $row.find('.net_unit_cost').val(net_unit_cost); // Store NET unit cost
        $row.find('.purchase-unit').val(unit);

        // Reload product table
        loadProductsFromLocalStorage();

        // Hide modal
        $('#editModal').modal('hide');
        currentRowIndex = null;
    });


    function productSearch(dataInput) {
        $.ajax({
            type: 'GET',
            url: 'lims_product_search/search',
            data: { data: dataInput },
            success: function(data) {
                let found = false;
                const productCode = data[1];
                const status = $('select[name="status"]').val();

                $(".product-code").each(function(index) {
                    if ($(this).val() === productCode) {
                        const $row = $('table.order-list tbody tr').eq(index);
                        let qty = parseFloat($row.find('.qty').val()) + 1;
                        $row.find('.qty').val(qty);

                        if (status == 1) {
                            $row.find('.recieved').val(qty);
                        }

                        calculateRowProductData(qty, index);
                        found = true;
                        return false; // break the loop
                    }
                });

                $("input[name='product_code_name']").val('');

                if (!found) {
                    let purchase_products = JSON.parse(localStorage.getItem('purchase_products')) || [];
                    let rowIndex = purchase_products.length;

                    const temp_unit_name = data[6].split(',');
                    const newRow = $(`
                        <tr data-index="${rowIndex}">
                            <td>${data[0]}
                                <br>
                                ${data[1]}
                                <button type="button" class="edit-product btn btn-link" data-index="${rowIndex}" data-toggle="modal"  data-target="#editModal">
                                <i class="dripicons-document-edit"></i></button>
                            </td>
                            <td><input type="text" style="width: 86px;" class="form-control qty" name="qty[]" value="1" required/></td>
                            <td class="recieved-product-qty ${status == 2 ? '' : 'd-none'}">
                                <input type="text" class="form-control recieved" name="recieved[]" value="${status == 2 ? 1 : status == 1 ? 1 : 0}" />
                            </td>
                            <td class="batch-no"><input type="text" class="form-control batch-no" name="batch_no[]" ${data[10] ? 'required' : ''}/></td>
                            <td class="expired-date"><input type="text" class="form-control expired-date" name="expired_date[]" ${data[10] ? 'required' : ''}/></td>
                            <td class="net_unit_cost">${(parseFloat(data[2]) * exchangeRate).toFixed({{$general_setting->decimal}})}</td>
                            <td class="discount">0.00</td>
                            <td class="tax">0.00</td>
                            <td class="sub-total">${(parseFloat(data[2]) * exchangeRate).toFixed({{$general_setting->decimal}})}</td>
                            <td><button type="button" class="ibtnDel btn btn-md btn-danger"><i class="dripicons-trash"></i></button></td>
                            <input type="hidden" class="product-code" name="product_code[]" value="${data[1]}"/>
                            <input type="hidden" class="product-id" name="product_id[]" value="${data[9]}"/>
                            <input type="hidden" class="purchase-unit" name="purchase_unit[]" value="${temp_unit_name[0]}"/>
                            <input type="hidden" class="net_unit_cost" name="net_unit_cost[]" value="${(parseFloat(data[2]) * exchangeRate).toFixed({{$general_setting->decimal}})}"/>
                            <input type="hidden" class="discount-value" name="discount[]" value="0"/>
                            <input type="hidden" class="tax-rate" name="tax_rate[]" value="${data[3]}"/>
                            <input type="hidden" class="tax-value" name="tax[]" value="0"/>
                            <input type="hidden" class="subtotal-value" name="subtotal[]" value="${(parseFloat(data[2]) * exchangeRate).toFixed({{$general_setting->decimal}})}"/>
                            <input type="hidden" class="imei-number" name="imei_number[]"/>
                            <input type="hidden" class="original-cost" value="${data[2]}"/>
                        </tr>
                    `);

                    const $tbody = $("table.order-list tbody");
                    $tbody.prepend(newRow);

                    const rowindex = 0; // Always prepending at top
                    product_cost.splice(rowindex, 0, parseFloat(data[2]));
                    product_discount.splice(rowindex, 0, '{{number_format(0, $general_setting->decimal, '.', '')}}');
                    tax_rate.splice(rowindex, 0, parseFloat(data[3]));
                    tax_name.splice(rowindex, 0, data[4]);
                    tax_method.splice(rowindex, 0, data[5]);
                    unit_name.splice(rowindex, 0, data[6]);
                    unit_operator.splice(rowindex, 0, data[7]);
                    unit_operation_value.splice(rowindex, 0, data[8]);
                    is_imei.splice(rowindex, 0, data[11]);

                    // Add product to localStorage
                    const productData = {
                        name: data[0],
                        product_code: data[1],
                        product_id: data[9],
                        qty: 1,
                        recieved: status == 2 ? 1 : status == 1 ? 1 : 0,
                        batch_no: '',
                        expired_date: '',
                        original_cost: data[2],
                        discount: 0,
                        tax_rate: data[3],
                        tax: 0,
                        subtotal: parseFloat(data[2]) * exchangeRate,
                        imei: '',
                        product_discount: 0,
                        purchase_unit: temp_unit_name[0],
                        unit_cost: parseFloat(data[2]) * exchangeRate,
                        net_unit_cost: parseFloat(data[2]) * exchangeRate,
                        total: parseFloat(data[2]) * exchangeRate
                    };

                    purchase_products.unshift(productData);
                    localStorage.setItem('purchase_products', JSON.stringify(purchase_products));

                    if (data[11]) {
                        $tbody.find('tr').eq(0).find('.edit-product').click();
                    }
                }
                calculateTotal();
            }
        });
    }

    function saveProductsToLocalStorage() {
        let products = [];
        $('table.order-list tbody tr').each(function () {
            const $tr = $(this);
            const name = $tr.find('td').eq(0).contents().filter(function () {
                return this.nodeType === 3;
            }).text().trim();

            const productData = {
                name: name,
                product_code: $tr.find('input.product-code').val() || '',
                product_id: $tr.find('input.product-id').val() || '',
                qty: $tr.find('input.qty').val() || 0,
                recieved: $tr.find('input.recieved').val() || 0,
                batch_no: $tr.find('input.batch-no').val() || '',
                expired_date: $tr.find('input.expired-date').val() || '',
                original_cost: $tr.find('input.original-cost').val() || 0,
                discount: $tr.find('input.discount-value').val() || 0,
                tax_rate: $tr.find('input.tax-rate').val() || 0,
                tax: $tr.find('input.tax-value').val() || 0,
                subtotal: $tr.find('input.subtotal-value').val() || 0,
                imei: $tr.find('input.imei-number').val() || '',
                product_discount: $tr.find('input.discount-value').val() || 0,
                purchase_unit: $tr.find('input.purchase-unit').val() || '',
                unit_cost: $tr.find('input.net_unit_cost').val() || 0,
                net_unit_cost: $tr.find('input.net_unit_cost').val() || 0,
                total: parseFloat($tr.find('.sub-total').text()) || 0
            };

            products.push(productData);
        });

        localStorage.setItem('purchase_products', JSON.stringify(products));
        calculateTotal();
    }

    function loadProductsFromLocalStorage() {
    const purchase_products = JSON.parse(localStorage.getItem('purchase_products')) || [];
    const $tbody = $('table.order-list tbody');
    $tbody.empty();

    // Initialize arrays if they don't exist
    if (product_cost.length === 0) {
        product_cost = [];
        product_discount = [];
        tax_rate = [];
        tax_name = [];
        tax_method = [];
        unit_name = [];
        unit_operator = [];
        unit_operation_value = [];
        is_imei = [];
    }

    purchase_products.forEach((product, index) => {
        const status = $('select[name="status"]').val();
        const qty = parseFloat(product.qty || 1);
        const unit_cost = parseFloat(product.unit_cost || 0);

        // Get product discount (unit discount)
        const unit_discount = parseFloat(product.product_discount || product.discount || 0);

        // Calculate net unit cost
        const net_unit_cost = unit_cost - unit_discount;

        // Get tax rate
        const tax_rate_val = parseFloat(product.tax_rate || 0);

        // Calculate values correctly
        const subtotal = qty * net_unit_cost;
        const tax_value = (subtotal * tax_rate_val) / 100;
        const total = subtotal + tax_value;

        // Calculate total discount for display
        const total_discount = unit_discount * qty;

        const newRow = $(`
            <tr data-index="${index}">
                <td>${product.name || ''}<br>${product.product_code || ''}
                    <button type="button" class="edit-product btn btn-link" data-toggle="modal" data-index="${index}" data-target="#editModal">
                        <i class="dripicons-document-edit"></i>
                    </button>
                </td>
                <td><input type="number" style="width: 86px;" class="form-control qty" name="qty[]" value="${qty}" required/></td>
                <td class="recieved-product-qty ${status == 2 ? '' : 'd-none'}">
                    <input type="number" step="0.01" class="form-control recieved" name="recieved[]" value="${product.recieved || 0}" />
                </td>
                <td class="batch-no"><input type="text" class="form-control batch-no" name="batch_no[]" value="${product.batch_no || ''}" /></td>
                <td class="expired-date"><input type="text" class="form-control expired-date" name="expired_date[]" value="${product.expired_date || ''}" /></td>
                <td class="net_unit_cost">${net_unit_cost.toFixed(2)}</td>
                <td class="discount">${total_discount.toFixed(2)}</td>
                <td class="tax">${tax_value.toFixed(2)}</td>
                <td class="sub-total">${total.toFixed(2)}</td>
                <td><button type="button" class="ibtnDel btn btn-md btn-danger"><i class="dripicons-trash"></i></button></td>

                <input type="hidden" class="product-code" name="product_code[]" value="${product.product_code || ''}"/>
                <input type="hidden" class="product-id" name="product_id[]" value="${product.product_id || ''}"/>
                <input type="hidden" class="purchase-unit" name="purchase_unit[]" value="${product.purchase_unit || ''}"/>
                <input type="hidden" class="net_unit_cost" name="net_unit_cost[]" value="${net_unit_cost}"/>
                <input type="hidden" class="discount-value" name="discount[]" value="${total_discount}"/>
                <input type="hidden" class="tax-rate" name="tax_rate[]" value="${tax_rate_val}"/>
                <input type="hidden" class="tax-value" name="tax[]" value="${tax_value}"/>
                <input type="hidden" class="subtotal-value" name="subtotal[]" value="${total}"/>
                <input type="hidden" class="imei-number" name="imei_number[]" value="${product.imei || ''}"/>
                <input type="hidden" class="original-cost" value="${product.original_cost || unit_cost}"/>
            </tr>
        `);

        $tbody.append(newRow);

        // Update arrays for calculations
        product_cost[index] = unit_cost;
        product_discount[index] = unit_discount; // Store unit discount
        tax_rate[index] = tax_rate_val;
        tax_name[index] = product.tax_name || '';
        tax_method[index] = product.tax_method || '';
        unit_name[index] = product.unit_name || '';
        unit_operator[index] = product.unit_operator || '';
        unit_operation_value[index] = product.unit_operation_value || '';
        is_imei[index] = product.is_imei || false;
    });

    calculateTotal();
}

    // function loadProductsFromLocalStorage() {
    //     const purchase_products = JSON.parse(localStorage.getItem('purchase_products')) || [];
    //     const $tbody = $('table.order-list tbody');
    //     $tbody.empty();

    //     purchase_products.forEach((product, index) => {
    //         const status = $('select[name="status"]').val();
    //         const qty = parseFloat(product.qty || 1);
    //         const unit_cost = parseFloat(product.unit_cost || 0);
    //         const net_unit_cost = parseFloat(product.net_unit_cost || 0);
    //         const discount = parseFloat(product.discount || 0);
    //         const tax_rate = parseFloat(product.tax_rate || 0);

    //         const subtotal = qty * net_unit_cost;
    //         const tax_value = (subtotal * tax_rate) / 100;
    //         const total = subtotal + tax_value;

    //         const newRow = $(`
    //             <tr data-index="${index}">
    //                 <td>${product.name}<br>${product.product_code}
    //                     <button type="button" class="edit-product btn btn-link" data-toggle="modal" data-index="${index}" data-target="#editModal">
    //                         <i class="dripicons-document-edit"></i>
    //                     </button>
    //                 </td>
    //                 <td><input type="text" style="width: 86px;" class="form-control qty" name="qty[]" value="${qty}" required/></td>
    //                 <td class="recieved-product-qty ${status == 2 ? '' : 'd-none'}">
    //                     <input type="number" step="0.01" class="form-control recieved" name="recieved[]" value="${product.recieved || 0}" />
    //                 </td>
    //                 <td class="batch-no"><input type="text" class="form-control batch-no" name="batch_no[]" value="${product.batch_no || ''}" /></td>
    //                 <td class="expired-date"><input type="text" class="form-control expired-date" name="expired_date[]" value="${product.expired_date || ''}" /></td>
    //                 <td class="net_unit_cost">${net_unit_cost.toFixed(2)}</td>
    //                 <td class="discount">${discount.toFixed(2)}</td>
    //                 <td class="tax">${tax_value.toFixed(2)}</td>
    //                 <td class="sub-total">${total.toFixed(2)}</td>
    //                 <td><button type="button" class="ibtnDel btn btn-md btn-danger"><i class="dripicons-trash"></i></button></td>

    //                 <input type="hidden" class="product-code" name="product_code[]" value="${product.product_code}"/>
    //                 <input type="hidden" class="product-id" name="product_id[]" value="${product.product_id}"/>
    //                 <input type="hidden" class="purchase-unit" name="purchase_unit[]" value="${product.purchase_unit}"/>
    //                 <input type="hidden" class="net_unit_cost" name="net_unit_cost[]" value="${unit_cost}"/>
    //                 <input type="hidden" class="discount-value" name="discount[]" value="${discount}"/>
    //                 <input type="hidden" class="tax-rate" name="tax_rate[]" value="${tax_rate}"/>
    //                 <input type="hidden" class="tax-value" name="tax[]" value="${tax_value}"/>
    //                 <input type="hidden" class="subtotal-value" name="subtotal[]" value="${total}"/>
    //                 <input type="hidden" class="imei-number" name="imei_number[]" value="${product.imei || ''}"/>
    //                 <input type="hidden" class="original-cost" value="${product.original_cost}"/>
    //             </tr>
    //         `);

    //         $tbody.append(newRow);
    //     });

    //     calculateTotal();
    // }
//     function loadProductsFromLocalStorage() {
//     const purchase_products = JSON.parse(localStorage.getItem('purchase_products')) || [];
//     const $tbody = $('table.order-list tbody');
//     $tbody.empty();

//     purchase_products.forEach((product, index) => {
//         const status = $('select[name="status"]').val();
//         const qty = parseFloat(product.qty || 1);
//         const unit_cost = parseFloat(product.unit_cost || 0);
//         const discount = parseFloat(product.discount || 0);
//         const tax_rate = parseFloat(product.tax_rate || 0);

//         // Calculate net unit cost (Unit Cost - Unit Discount)
//         const net_unit_cost = unit_cost - discount;
//         const subtotal = qty * net_unit_cost;
//         const tax_value = (subtotal * tax_rate) / 100;
//         const total = subtotal + tax_value;

//         const newRow = $(`
//             <tr data-index="${index}">
//                 <td>${product.name}<br>${product.product_code}
//                     <button type="button" class="edit-product btn btn-link" data-toggle="modal" data-index="${index}" data-target="#editModal">
//                         <i class="dripicons-document-edit"></i>
//                     </button>
//                 </td>
//                 <td><input type="text" style="width: 86px;" class="form-control qty" name="qty[]" value="${qty}" required/></td>
//                 <td class="recieved-product-qty ${status == 2 ? '' : 'd-none'}">
//                     <input type="number" step="0.01" class="form-control recieved" name="recieved[]" value="${product.recieved || 0}" />
//                 </td>
//                 <td class="batch-no"><input type="text" class="form-control batch-no" name="batch_no[]" value="${product.batch_no || ''}" /></td>
//                 <td class="expired-date"><input type="text" class="form-control expired-date" name="expired_date[]" value="${product.expired_date || ''}" /></td>
//                 <td class="net_unit_cost">${net_unit_cost.toFixed(2)}</td> <!-- Show NET unit cost -->
//                 <td class="discount">${discount.toFixed(2)}</td>
//                 <td class="tax">${tax_value.toFixed(2)}</td>
//                 <td class="sub-total">${total.toFixed(2)}</td>
//                 <td><button type="button" class="ibtnDel btn btn-md btn-danger"><i class="dripicons-trash"></i></button></td>

//                 <input type="hidden" class="product-code" name="product_code[]" value="${product.product_code}"/>
//                 <input type="hidden" class="product-id" name="product_id[]" value="${product.product_id}"/>
//                 <input type="hidden" class="purchase-unit" name="purchase-unit[]" value="${product.purchase_unit}"/>
//                 <input type="hidden" class="net_unit_cost" name="net_unit_cost[]" value="${net_unit_cost}"/> <!-- Store NET unit cost -->
//                 <input type="hidden" class="discount-value" name="discount[]" value="${discount}"/>
//                 <input type="hidden" class="tax-rate" name="tax_rate[]" value="${tax_rate}"/>
//                 <input type="hidden" class="tax-value" name="tax[]" value="${tax_value}"/>
//                 <input type="hidden" class="subtotal-value" name="subtotal[]" value="${total}"/>
//                 <input type="hidden" class="imei-number" name="imei_number[]" value="${product.imei || ''}"/>
//                 <input type="hidden" class="original-cost" value="${product.original_cost}"/>
//             </tr>
//         `);

//         $tbody.append(newRow);
//     });

//     calculateTotal();
// }

    function checkQuantity(purchase_qty, flag, rowindex) {
        if (typeof rowindex === 'undefined' || isNaN(rowindex)) {
            console.error('❌ rowindex is undefined or invalid');
            return;
        }

        $('#editModal').modal('hide');

        var $row = $('table.order-list tbody tr').eq(rowindex);

        $row.find('.qty').val(purchase_qty);

        var status = $('select[name="status"]').val();
        if (status == '1' || status == '2')
            $row.find('.recieved').val(purchase_qty);
        else
            $row.find('.recieved').val(0);

        if (flag) {
            var cost = parseFloat($row.find('.original-cost').val()) || 0;
            product_cost[rowindex] = cost * exchangeRate;
        }

        calculateRowProductData(purchase_qty, rowindex);
    }

    function calculateRowProductData(quantity, rowindex) {
        unitConversion(rowindex);
        var $row = $('table.order-list tbody tr').eq(rowindex);

        var cost = product_cost[rowindex] * quantity;
        var discount = product_discount[rowindex] * quantity;
        var tax_rate = $row.find('.tax-rate').val();
        var net_unit_cost = parseFloat($row.find('.net_unit_cost').val());
        var unit_cost = parseFloat($row.find('.unit_cost').val());
        var qty = parseFloat($row.find('.qty').val());


        if (!isNaN(tax_rate)) {
            tax_rate = parseFloat(tax_rate);
            var tax = (cost - discount) * (tax_rate / 100);
        } else {
            var tax = 0;
        }

        var subtotal = cost - discount + tax;

        $row.find('.discount').text(discount.toFixed({{$general_setting->decimal}}));
        $row.find('.discount-value').val(discount.toFixed({{$general_setting->decimal}}));
        $row.find('.tax').text(tax.toFixed({{$general_setting->decimal}}));
        $row.find('.tax-value').val(tax.toFixed({{$general_setting->decimal}}));
        $row.find('.sub-total').text(subtotal.toFixed({{$general_setting->decimal}}));
        $row.find('.subtotal-value').val(subtotal.toFixed({{$general_setting->decimal}}));

        // Update localStorage
        let purchase_products = JSON.parse(localStorage.getItem('purchase_products')) || [];
        if (purchase_products[rowindex]) {
            purchase_products[rowindex].qty = quantity;
            purchase_products[rowindex].discount = discount;
            purchase_products[rowindex].tax = tax;
            purchase_products[rowindex].subtotal = subtotal;
            purchase_products[rowindex].total = subtotal;
            localStorage.setItem('purchase_products', JSON.stringify(purchase_products));
        }

        calculateTotal();
    }

    function removeProductRowFromLocalStorage(index) {
        const arr = JSON.parse(localStorage.getItem('purchase_products') || '[]');
        arr.splice(index, 1);
        localStorage.setItem('purchase_products', JSON.stringify(arr));
    }

    function clearProductsLocalStorage() {
        localStorage.removeItem('purchase_products');
    }

    function unitConversion(rowindex) {
        // Check all required data exists before proceeding
        if (
            typeof unit_operator[rowindex] !== 'undefined' &&
            typeof unit_operation_value[rowindex] !== 'undefined' &&
            typeof product_cost[rowindex] !== 'undefined'
        ) {
            var operatorRaw = unit_operator[rowindex];
            var valueRaw = unit_operation_value[rowindex];

            var row_unit_operator = operatorRaw.slice(0, operatorRaw.indexOf(","));
            var row_unit_operation_value = parseFloat(
                valueRaw.slice(0, valueRaw.indexOf(","))
            );

            if (row_unit_operator === '*') {
                row_product_cost = product_cost[rowindex] * row_unit_operation_value;
            } else {
                row_product_cost = product_cost[rowindex] / row_unit_operation_value;
            }
        } else {
            console.warn("unitConversion error: Missing data at index", rowindex);
            row_product_cost = 0; // fallback value to avoid breaking
        }
    }

    function calculateTotal() {
        //Sum of quantity
        var total_qty = 0;
        $(".qty").each(function() {
            if ($(this).val() == '') {
                total_qty += 0;
            } else {
                total_qty += parseFloat($(this).val());
            }
        });
        $("#total-qty").text(total_qty);
        $('input[name="total_qty"]').val(total_qty);

        //Sum of discount
        var total_discount = 0;
        $(".discount").each(function() {
            total_discount += parseFloat($(this).text());
        });
        $("#total-discount").text(total_discount.toFixed({{$general_setting->decimal}}));
        $('input[name="total_discount"]').val(total_discount.toFixed({{$general_setting->decimal}}));

        //Sum of tax
        var total_tax = 0;
        $(".tax").each(function() {
            total_tax += parseFloat($(this).text());
        });
        $("#total-tax").text(total_tax.toFixed({{$general_setting->decimal}}));
        $('input[name="total_tax"]').val(total_tax.toFixed({{$general_setting->decimal}}));

        //Sum of subtotal
        var total = 0;
        $(".sub-total").each(function() {
            total += parseFloat($(this).text());
        });
        $("#total").text(total.toFixed({{$general_setting->decimal}}));
        $('input[name="total_cost"]').val(total.toFixed({{$general_setting->decimal}}));

        $('#shipping_cost').text(0);
        $('input[name="shipping_cost"]').val(0);
        $('#order_tax_rate').text(0);
        $('input[name="order_tax_rate"]').val(0);

        calculateGrandTotal();
    }

    function calculateGrandTotal() {
        var item = $('table.order-list tbody tr:last').index();
        var total_qty = parseFloat($('#total-qty').text());
        var subtotal = parseFloat($('#total').text());
        var order_tax = parseFloat($('select[name="order_tax_rate"]').val());
        if (isNaN(order_tax)) {
            order_tax = 0;
        }
        if($('input[name="order_discount"]').val()) {
            if(!currencyChange)
                var order_discount = parseFloat($('input[name="order_discount"]').val());
            else
                var order_discount = parseFloat($('input[name="order_discount"]').val()) * exchangeRate;
        }
        else
            var order_discount = {{number_format(0, $general_setting->decimal, '.', '')}};

        if($('input[name="shipping_cost"]').val()) {
            if(!currencyChange)
                var shipping_cost = parseFloat($('input[name="shipping_cost"]').val());
            else
                var shipping_cost = parseFloat($('input[name="shipping_cost"]').val()) * exchangeRate;
        }
        else
            var shipping_cost = {{number_format(0, $general_setting->decimal, '.', '')}};

        item = ++item + '(' + total_qty + ')';
        order_tax = (subtotal - order_discount) * (order_tax / 100);
        var grand_total = (subtotal + order_tax + shipping_cost) - order_discount;

        $('#item').text(item);
        $('input[name="item"]').val($('table.order-list tbody tr:last').index() + 1);
        $('#subtotal').text(subtotal.toFixed({{$general_setting->decimal}}));
        $('#order_tax').text(order_tax.toFixed({{$general_setting->decimal}}));
        $('input[name="order_tax"]').val(order_tax.toFixed({{$general_setting->decimal}}));
        $('#order_discount').text(order_discount.toFixed({{$general_setting->decimal}}));
        $('input[name="order_discount"]').val(order_discount);
        $('#shipping_cost').text(shipping_cost.toFixed({{$general_setting->decimal}}));
        $('input[name="shipping_cost"]').val(shipping_cost);
        $('#grand_total').text(grand_total.toFixed({{$general_setting->decimal}}));
        $('input[name="grand_total"]').val(grand_total.toFixed({{$general_setting->decimal}}));
        currencyChange = false;
    }

    $('input[name="order_discount"]').on("input", function() {
        calculateGrandTotal();
    });

    $('input[name="shipping_cost"]').on("input", function() {
        calculateGrandTotal();
    });

    $('select[name="order_tax_rate"]').on("change", function() {
        calculateGrandTotal();
    });

    $(window).keydown(function(e){
        if (e.which == 13) {
            var $targ = $(e.target);
            if (!$targ.is("textarea") && !$targ.is(":button,:submit")) {
                var focusNext = false;
                $(this).find(":input:visible:not([disabled],[readonly]), a").each(function(){
                    if (this === e.target) {
                        focusNext = true;
                    }
                    else if (focusNext){
                        $(this).focus();
                        return false;
                    }
                });
                return false;
            }
        }
    });

    $('#purchase-form').on('submit',function(e){
        var rownumber = $('table.order-list tbody tr:last').index();
        if (rownumber < 0) {
            alert("Please insert product to order table!")
            e.preventDefault();
        }
        else if($('select[name="status"]').val() != 1)
        {
            flag = 0;
            $(".qty").each(function() {
                const rowindex = $(this).closest('tr').index();
                quantity =  $(this).val();
                recieved = $('table.order-list tbody tr:nth-child(' + (rowindex + 1) + ')').find('.recieved').val();

                if(quantity != recieved){
                    flag = 1;
                    return false;
                }
            });
            if(!flag){
                alert('Quantity and Recieved value is same! Please Change Purchase Status or Recieved value');
                e.preventDefault();
            }
            else
                $(".batch-no, .expired-date").prop('disabled', false);
        }
        else {
            $(".batch-no, .expired-date").prop('disabled', false);
            $("#submit-btn").prop('disabled', true);
        }
        clearProductsLocalStorage();
    });
</script>

<script type="text/javascript" src="https://js.stripe.com/v3/"></script>
@endpush
