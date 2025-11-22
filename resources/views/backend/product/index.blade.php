@extends('backend.layout.main')
@section('content')

@if(session()->has('create_message'))
    <div class="alert alert-success alert-dismissible text-center"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>{{ session()->get('create_message') }}</div>
@endif
@if(session()->has('edit_message'))
    <div class="alert alert-success alert-dismissible text-center"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>{{ session()->get('edit_message') }}</div>
@endif
@if(session()->has('import_message'))
    <div class="alert alert-success alert-dismissible text-center"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>{{ session()->get('import_message') }}</div>
@endif
@if(session()->has('not_permitted'))
    <div class="alert alert-danger alert-dismissible text-center"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>{{ session()->get('not_permitted') }}</div>
@endif
@if(session()->has('message'))
    <div class="alert alert-danger alert-dismissible text-center">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        {{ session()->get('message') }}
    </div>
@endif

<style>
    #product-data-table_filter{
        display: flex;
        flex-direction: row;
        flex-wrap: nowrap;
        align-content: center;
        justify-content: space-between;
    }
    .dataTables_processing{
        border-radius: 5px!important;
        overflow: hidden!important;
        box-shadow: 0 0 8px 1px #000887ab;
        animation: colorSwap 1.5s infinite alternate;
        background: #4D55CC; 
        color: #fff;
    }

    @keyframes colorSwap {
        0% {
            background-color: #2DAA9E;  /* Start with one color */
            color: white;
        }
        100% {
            background-color: #003092;  /* Swap to another color */
            color: #fff;
        }
    }
</style>

<section>
    <div id="filter-categories" class="d-flex w-50">
        <div class="form-group d-flex align-items-center w-100">
            <label class="m-0">{{trans('file.category')}}</label>
            <select id="pr_category" class="form-control ml-2" name="category_pr">
                <option value="0">All</option>
                @foreach($lims_category_list as $category)
                <option value="{{$category->id}}">{{$category->name}}</option>
                @endforeach
            </select>
        </div>
    </div>

    <div class="container-fluid top-buttons">
        @if(in_array("products-add", $all_permission))
            <a href="{{route('products.create')}}" class="btn btn-info add-product-btn"><i class="dripicons-plus"></i> {{__('file.add_product')}}</a>
            <a href="#" data-toggle="modal" data-target="#importProduct" class="btn btn-primary add-product-btn"><i class="dripicons-copy"></i> {{__('file.import_product')}}</a>
            <a href="#" data-toggle="modal" data-target="#bulkUpdateProduct" class="btn btn-secondary add-product-btn"><i class="dripicons-copy"></i> {{__('file.bulkupdate_product')}}</a>
            <a href="{{route('product.downloadBulkProducts')}}" class="btn btn-warning add-product-btn"><i class="dripicons-copy"></i> {{__('file.bulkdownload_product')}}</a>
        @endif
        <span class="total-product-count ml-3 font-weight-bold">Total Products: 0</span>
    </div>

    <div class="table-responsive" style="padding-left: 25px;">
        <table id="product-data-table" class="table" style="width: 100%">
            <thead>
                <tr>
                    <th class="not-exported"></th>
                    <th>{{trans('file.name')}}</th>
                    <th>{{trans('file.Code')}}</th>
                    <th>{{trans('file.Brand')}}</th>
                    <th>{{trans('file.category')}}</th>
                    <th>{{trans('file.Quantity')}}</th>
                    <th>{{trans('file.Price')}}</th>
                    <th>{{trans('file.Cost')}}</th>
                    <th>{{trans('file.Expiry Date')}}</th>
                    <th class="not-exported">{{trans('file.action')}}</th>
                </tr>
            </thead>
        </table>
    </div>
</section>

<div id="importProduct" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" class="modal fade text-left">
    <div role="document" class="modal-dialog">
      <div class="modal-content">
        {!! Form::open(['route' => 'product.import', 'method' => 'post', 'files' => true]) !!}
        <div class="modal-header">
          <h5 id="exampleModalLabel" class="modal-title">Import Product</h5>
          <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true"><i class="dripicons-cross"></i></span></button>
        </div>
        <div class="modal-body">
          <p class="italic"><small>{{trans('file.The field labels marked with * are required input fields')}}.</small></p>
           <p>{{trans('file.The correct column order is')}} (image, name*, code*, type*, brand, category*, unit_code*, cost*, price*, product_details, variant_name, item_code, additional_price) {{trans('file.and you must follow this')}}.</p>
           <p>{{trans('file.To display Image it must be stored in')}} images/product {{trans('file.directory')}}. {{trans('file.Image name must be same as product name')}}</p>
           <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label>{{trans('file.Upload CSV File')}} *</label>
                        {{Form::file('file', array('class' => 'form-control','required'))}}
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label> {{trans('file.Sample File')}}</label>
                        <!--<a href="sample_file/sample_products.csv" class="btn btn-info btn-block btn-md"><i class="dripicons-download"></i>  {{trans('file.Download')}}</a>-->
                        <a href="{{ route('sample.download') }}" class="btn btn-info btn-block btn-md">
                            <i class="dripicons-download"></i> {{ trans('file.Download') }}
                        </a>
                    </div>
                </div>
           </div>
            {{Form::submit('Submit', ['class' => 'btn btn-primary'])}}
        </div>
        {!! Form::close() !!}
      </div>
    </div>
</div>

<div id="bulkUpdateProduct" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" class="modal fade text-left">
    <div role="document" class="modal-dialog">
      <div class="modal-content">
        {!! Form::open(['route' => 'product.bulkUpdateproduct', 'method' => 'post', 'files' => true]) !!}
        <div class="modal-header">
          <h5 id="exampleModalLabel" class="modal-title">Bulk Update Product</h5>
          <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true"><i class="dripicons-cross"></i></span></button>
        </div>
        <div class="modal-body">
            <p class="italic"><small>{{trans('file.The field labels marked with * are required input fields')}}.</small></p>
            <p>
                {{trans('file.The correct column order is')}} 
                (name*, code*, brand, category*, unit_code*, cost*, price*, quanit, expiry_date)
                {{trans('file.and you must follow this')}}.
            </p>
            <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>{{trans('file.Upload CSV File')}} *</label>
                            {{Form::file('file', array('class' => 'form-control','required'))}}
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label> {{trans('file.Template File')}}</label>
                            <a href="{{route('product.downloadBulkProducts')}}" class="btn btn-info btn-block btn-md"><i class="dripicons-download"></i>  {{trans('file.Download')}}</a>
                        </div>
                    </div>
            </div>
            {{Form::submit('Submit', ['class' => 'btn btn-primary'])}}
        </div>
        {!! Form::close() !!}
      </div>
    </div>
</div>

<div id="product-details" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" class="modal fade text-left">
    <div role="document" class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 id="exampleModalLabel" class="modal-title">{{trans('Product Details')}}</h5>
          <button id="print-btn" type="button" class="btn btn-default btn-sm ml-3"><i class="dripicons-print"></i> {{trans('file.Print')}}</button>
          <button type="button" id="close-btn" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true"><i class="dripicons-cross"></i></span></button>
        </div>
        <div class="modal-body">
            <div class="row">
                <div class="col-md-5" id="slider-content"></div>
                <div class="col-md-5 offset-1" id="product-content"></div>
                @if($role_id <= 2)
                <div class="col-md-12 mt-2" id="product-warehouse-section">
                    <h5>{{trans('file.Warehouse Quantity')}}</h5>
                    <table class="table table-bordered table-hover product-warehouse-list">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
                @endif
            </div>
        </div>
      </div>
    </div>
</div>

@endsection
@push('scripts')
<script>

    $("ul#product").siblings('a').attr('aria-expanded','true');
    $("ul#product").addClass("show");
    $("ul#product #product-list-menu").addClass("active");

    @if(config('database.connections.saleprosaas_landlord'))
        if(localStorage.getItem("message")) {
            alert(localStorage.getItem("message"));
            localStorage.removeItem("message");
        }

        numberOfProduct = <?php echo json_encode($numberOfProduct)?>;
        $.ajax({
            type: 'GET',
            async: false,
            url: '{{route("package.fetchData", $general_setting->package_id)}}',
            success: function(data) {
                if(data['number_of_product'] > 0 && data['number_of_product'] <= numberOfProduct) {
                    $("a.add-product-btn").addClass('d-none');
                }
            }
        });
    @endif

    function confirmDelete() {
        if (confirm("Are you sure want to delete?")) {
            return true;
        }
        return false;
    }

    var columns = [
        {"data": "key"},
        {"data": "name"},
        {"data": "code"},
        {"data": "brand"},
        {"data": "category"},
        {"data": "qty"},
        {"data": "price"},
        {"data": "cost"},
        {"data": "expire_date"}
    ];
    var field_name = <?php echo json_encode($field_name) ?>;
    for(i = 0; i < field_name.length; i++) {
        columns.push({"data": field_name[i]});
    }
    columns.push({"data": "options"});
    
    var warehouse_id = $('#warehouse_id').val();
    var warehouse = [];
    var variant = [];
    var qty = [];
    var htmltext;
    var slidertext;
    var product_id = [];
    var all_permission = <?php echo json_encode($all_permission) ?>;
    var role_id = <?php echo json_encode($role_id) ?>;
    var user_verified = <?php echo json_encode(env('USER_VERIFIED')) ?>;
    var logoUrl = <?php echo json_encode(url('logo', $general_setting->site_logo)) ?>;

    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    });

    $("#warehouse_id").val(warehouse_id);

    $( "#select_all" ).on( "change", function() {
        if ($(this).is(':checked')) {
            $("tbody input[type='checkbox']").prop('checked', true);
        }
        else {
            $("tbody input[type='checkbox']").prop('checked', false);
        }
    });

    $(document).on("click", "tr.product-link td:not(:first-child, :last-child)", function() {
        productDetails($(this).parent().data('product'), $(this).parent().data('imagedata'));
    });

    $(document).on("click", ".view", function(){
        var product = $(this).parent().parent().parent().parent().parent().data('product');
        var imagedata = $(this).parent().parent().parent().parent().parent().data('imagedata');
        productDetails(product, imagedata);
    });

    $("#print-btn").on("click", function() {
          var divToPrint=document.getElementById('product-details');
          var newWin=window.open('','Print-Window');
          newWin.document.open();
          newWin.document.write('<link rel="stylesheet" href="<?php echo asset('vendor/bootstrap/css/bootstrap.min.css') ?>" type="text/css"><style type="text/css">@media print {.modal-dialog { max-width: 1000px;} }</style><body onload="window.print()">'+divToPrint.innerHTML+'</body>');
          newWin.document.close();
          setTimeout(function(){newWin.close();},10);
    });

    function productDetails(product, imagedata) {
        product[11] = product[11].replace(/@/g, '"');
        htmltext = slidertext = '';

        htmltext = `<p><strong>{{trans("file.Type")}}: </strong>${product[0]}</p>
            <p><strong>{{trans("file.name")}}: </strong>${product[1]}</p>
            <p><strong>{{trans("file.Code")}}: </strong>${product[2]}</p>
            <p><strong>{{trans("file.Brand")}}: </strong>${product[3]}</p>
            <p><strong>{{trans("file.category")}}: </strong>${product[4]}</p>
            <p><strong>{{trans("file.Quantity")}}: </strong>${product[17]}</p>
            <p><strong>{{trans("file.Unit")}}: </strong>${product[5]}</p>
            <p><strong>{{trans("file.Cost")}}: </strong>${product[6]}</p>
            <p><strong>{{trans("file.Price")}}: </strong>${product[7]}</p>
            <p><strong>{{trans("file.Tax")}}: </strong>${product[8]}</p>
            <p><strong>{{trans("file.Tax Method")}} : </strong>${product[9]}</p>
            <p><strong>{{trans("file.Alert Quantity")}} : </strong>${product[10]}</p>
            <p><strong>{{trans("file.Product Details")}}: </strong></p>${product[11]}`;

        if(product[18]) {
            var product_image = product[18].split(",");
            if(product_image.length > 1) {
                slidertext = '<div id="product-img-slider" class="carousel slide" data-ride="carousel"><div class="carousel-inner">';
                for (var i = 0; i < product_image.length; i++) {
                    if(!i)
                        slidertext += '<div class="carousel-item active"><img src="images/product/'+product_image[i]+'" height="300" width="100%"></div>';
                    else
                        slidertext += '<div class="carousel-item"><img src="images/product/'+product_image[i]+'" height="300" width="100%"></div>';
                }
                slidertext += '</div><a class="carousel-control-prev" href="#product-img-slider" data-slide="prev"><span class="carousel-control-prev-icon" aria-hidden="true"></span><span class="sr-only">Previous</span></a><a class="carousel-control-next" href="#product-img-slider" data-slide="next"><span class="carousel-control-next-icon" aria-hidden="true"></span><span class="sr-only">Next</span></a></div>';
            }
            else {
                slidertext = '<img src="images/product/'+product[18]+'" height="300" width="100%">';
            }
        }
        else {
            slidertext = '<img src="images/product/zummXD2dvAtI.png" height="300" width="100%">';
        }
        $("#combo-header").text('');
        $("table.item-list thead").remove();
        $("table.item-list tbody").remove();
        $("table.product-warehouse-list thead").remove();
        $("table.product-warehouse-list tbody").remove();
        $(".product-variant-list thead").remove();
        $(".product-variant-list tbody").remove();
        $(".product-variant-warehouse-list thead").remove();
        $(".product-variant-warehouse-list tbody").remove();
        $("#product-warehouse-section").addClass('d-none');
        $("#product-variant-section").addClass('d-none');
        $("#product-variant-warehouse-section").addClass('d-none');
        if(product[0] == 'combo') {
            $("#combo-header").text('{{trans("file.Combo Products")}}');
            product_list = product[13].split(",");
            variant_list = product[14].split(",");
            qty_list = product[15].split(",");
            price_list = product[16].split(",");
            $(".item-list thead").remove();
            $(".item-list tbody").remove();
            var newHead = $("<thead>");
            var newBody = $("<tbody>");
            var newRow = $("<tr>");
            newRow.append('<th>{{trans("file.product")}}</th><th>{{trans("file.Quantity")}}</th><th>{{trans("file.Price")}}</th>');
            newHead.append(newRow);

            $(product_list).each(function(i) {
                if(!variant_list[i])
                    variant_list[i] = 0;
                $.get('products/getdata/' + product_list[i] + '/' + variant_list[i], function(data) {
                    var newRow = $("<tr>");
                    var cols = '';
                    cols += '<td>' + data['name'] +' [' + data['code'] + ']</td>';
                    cols += '<td>' + qty_list[i] + '</td>';
                    cols += '<td>' + price_list[i] + '</td>';
                    cols += '<td>' + price_list[i] + '</td>';

                    newRow.append(cols);
                    newBody.append(newRow);
                });
            });

            $("table.item-list").append(newHead);
            $("table.item-list").append(newBody);
        }
        if(product[0] == 'standard' || product[0] == 'combo') {
            if(product[19]) {
                $.get('products/variant-data/' + product[12], function(variantData) {
                    var newHead = $("<thead>");
                    var newBody = $("<tbody>");
                    var newRow = $("<tr>");
                    newRow.append('<th>{{trans("file.Variant")}}</th><th>{{trans("file.Item Code")}}</th><th>{{trans("file.Additional Cost")}}</th><th>{{trans("file.Additional Price")}}</th><th>{{trans("file.Qty")}}</th>');
                    newHead.append(newRow);
                    $.each(variantData, function(i) {
                        var newRow = $("<tr>");
                        var cols = '';
                        cols += '<td>' + variantData[i]['name'] + '</td>';
                        cols += '<td>' + variantData[i]['item_code'] + '</td>';
                        if(variantData[i]['additional_cost'])
                            cols += '<td>' + variantData[i]['additional_cost'] + '</td>';
                        else
                            cols += '<td>0</td>';
                        if(variantData[i]['additional_price'])
                            cols += '<td>' + variantData[i]['additional_price'] + '</td>';
                        else
                            cols += '<td>0</td>';
                        cols += '<td>' + variantData[i]['qty'] + '</td>';

                        newRow.append(cols);
                        newBody.append(newRow);
                    });
                    $("table.product-variant-list").append(newHead);
                    $("table.product-variant-list").append(newBody);
                });
                $("#product-variant-section").removeClass('d-none');
            }
            if(role_id <= 2) {
                $.get('products/product_warehouse/' + product[12], function(data) {
                    if(data.product_warehouse[0].length != 0) {
                        warehouse = data.product_warehouse[0];
                        qty = data.product_warehouse[1];
                        batch = data.product_warehouse[2];
                        expired_date = data.product_warehouse[3];
                        imei_numbers = data.product_warehouse[4];
                        var newHead = $("<thead>");
                        var newBody = $("<tbody>");
                        var newRow = $("<tr>");
                        var productQty = 0;
                        newRow.append('<th>{{trans("file.Warehouse")}}</th><th>{{trans("file.Batch No")}}</th><th>{{trans("file.Expired Date")}}</th><th>{{trans("file.Quantity")}}</th><th>{{trans("file.IMEI or Serial Numbers")}}</th>');
                        newHead.append(newRow);
                        $.each(warehouse, function(index) {
                            // productQty += qty[index];
                            var newRow = $("<tr>");
                            var cols = '';
                            cols += '<td>' + warehouse[index] + '</td>';
                            cols += '<td>' + batch[index] + '</td>';
                            cols += '<td>' + expired_date[index] + '</td>';
                            cols += '<td>' + qty[index] + '</td>';
                            cols += '<td>' + imei_numbers[index] + '</td>';

                            newRow.append(cols);
                            newBody.append(newRow);
                            $("table.product-warehouse-list").append(newHead);
                            $("table.product-warehouse-list").append(newBody);
                        });
                        // console.log(productQty);
                        $("#product-warehouse-section").removeClass('d-none');
                    }
                    if(data.product_variant_warehouse[0].length != 0) {
                        warehouse = data.product_variant_warehouse[0];
                        variant = data.product_variant_warehouse[1];
                        qty = data.product_variant_warehouse[2];
                        var newHead = $("<thead>");
                        var newBody = $("<tbody>");
                        var newRow = $("<tr>");
                        newRow.append('<th>{{trans("file.Warehouse")}}</th><th>{{trans("file.Variant")}}</th><th>{{trans("file.Quantity")}}</th>');
                        newHead.append(newRow);
                        $.each(warehouse, function(index){
                            var newRow = $("<tr>");
                            var cols = '';
                            cols += '<td>' + warehouse[index] + '</td>';
                            cols += '<td>' + variant[index] + '</td>';
                            cols += '<td>' + qty[index] + '</td>';

                            newRow.append(cols);
                            newBody.append(newRow);
                            $("table.product-variant-warehouse-list").append(newHead);
                            $("table.product-variant-warehouse-list").append(newBody);
                        });
                        $("#product-variant-warehouse-section").removeClass('d-none');
                    }
                });
            }
        }

        $('#product-content').html(htmltext);
        $('#slider-content').html(slidertext);
        $('#product-details').modal('show');
        $('#product-img-slider').carousel(0);
    }

    $(document).ready(function() {
        $(document).ready(function() {
            var table = $('#product-data-table').DataTable({
                responsive: true,
                fixedHeader: {
                    header: true,
                    footer: true
                },
                processing: true,
                serverSide: true,
                pagingType: "full_numbers",
                lengthChange: true,
                paging: true,
                pageLength: 10,
                searching: true,
                ordering: true,
                info: true,
                ajax: {
                    url: "{{route('ajax.loader.product-data')}}",
                    data: function(d) {
                        d.all_permission = all_permission;
                        d.warehouse_id = $('#warehouse_id').val();
                        d.category_id = $('#pr_category').val();
                    },
                    dataType: "json",
                    type: "post",
                    error: function(response) {
                        console.log(response);
                    },
                    // success: function(response) {
                    //     console.log(response);
                    // },
                },
                "createdRow": function(row, data, dataIndex) {
                    $(row).addClass('product-link');
                    $(row).attr('data-product', data['product']);
                },
                "columns": columns,
                'language': {
                    'paginate': {
                        'previous': '<i class="dripicons-chevron-left"></i>',
                        'next': '<i class="dripicons-chevron-right"></i>'
                    },
                    processing: '<div class="custom-processing-screen"><span class="loading" >PROCESSING</span></div>',
                },
                order: [['2', 'asc']],
                'columnDefs': [
                    {
                        "orderable": false,
                        'targets': [0, 1, 9]
                    },
                    {
                        'render': function(data, type, row, meta) {
                            if (type === 'display') {
                                data = '<div class="checkbox"><input type="checkbox" class="dt-checkboxes"><label></label></div>';
                            }
                            return data;
                        },
                        'checkboxes': {
                            'selectRow': true,
                            'selectAllRender': '<div class="checkbox"><input type="checkbox" class="dt-checkboxes"><label></label></div>'
                        },
                        'targets': [0]
                    },
                    {
                        targets: [9],
                        createdCell: function(td, cellData, rowData, row, col) {
                            $(td).html(cellData);
                        }
                    }
                ],
                'lengthMenu': [[10, 25, 50, -1], [10, 25, 50, "All"]],
                dom: '<"row"lfB>rtip',
                buttons: [
                    {
                        extend: 'excel',
                        text: '<i title="export to excel" class="dripicons-document-new" style="font-size: 12px;"></i>',
                        exportOptions: {
                            columns: ':visible:not(.not-exported)',
                            rows: ':visible',
                            format: {
                                body: function ( data, row, column, node ) {
                                    if (column === 0 && (data.indexOf('<img src=') !== -1)) {
                                        var regex = /<img.*?src=['"](.*?)['"]/;
                                        data = regex.exec(data)[1];
                                    }
                                    return data;
                                }
                            }
                        }
                    },
                    {
                        extend: 'print',
                        title: '',
                        text: '<i title="print" class="fa fa-print" style="font-size: 12px;"></i>',
                        exportOptions: {
                            columns: ':visible:not(.not-exported)',
                            rows: ':visible',
                            stripHtml: false
                        },
                        repeatingHead: {
                            logo: logoUrl,
                            logoPosition: 'left',
                            logoStyle: '',
                            title: '<h3>Product List</h3>'
                        }
                    },
                    {
                        text: '<i title="delete" class="dripicons-cross" style="font-size: 12px;"></i>',
                        className: 'buttons-delete',
                        action: function ( e, dt, node, config ) {
                            product_id.length = 0;
                            $(':checkbox:checked').each(function(i){
                                if(i){
                                    var product_data = $(this).closest('tr').data('product');
                                    if(product_data)
                                        product_id[i-1] = product_data[12];
                                }
                            });
                            if(product_id.length && confirmDelete()) {
                                $.ajax({
                                    type:'POST',
                                    url:'products/deletebyselection',
                                    data:{
                                        productIdArray: product_id
                                    },
                                    success:function(data) {
                                        alert(data);
                                        //dt.rows({ page: 'current', selected: true }).deselect();
                                        dt.rows({ page: 'current', selected: true }).remove().draw(false);
                                    }
                                });
                            }
                            else if(!product_id.length)
                                alert('No product is selected!');
                        }
                    },
                    {
                        extend: 'colvis',
                        text: '<i title="column visibility" class="fa fa-eye" style="font-size: 12px;"></i>',
                        columns: ':gt(0)'
                    },
                ],
                "drawCallback": function (settings) {
                    var totalRecords = settings._iRecordsTotal;

                    var totalCountElement = $('.top-buttons .total-product-count');

                    if (totalCountElement.length) {
                        totalCountElement.text(`Total Products: ${totalRecords}`);
                    } else {
                        $('.top-buttons').append(
                            `<span class="total-product-count ml-3">Total Products: ${totalRecords}</span>`
                        );
                    }
                },
                initComplete: function() {
                    $("body").removeClass("loading");
                }
            });
            
            $("#filter-categories").insertBefore("#product-data-table_filter label");
            $("#product-data-table_filter label").addClass("filter-half-width");

            $('#pr_category').on('change', function () {
                table.ajax.reload();
            });
    
            $('#warehouse_id').on('change', function () {
                table.ajax.reload();
            });
        });


    } );

    if(all_permission.indexOf("products-delete") == -1)
        $('.buttons-delete').addClass('d-none');

    $('select').selectpicker();

</script>
@endpush
