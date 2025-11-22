@extends('backend.layout.main') @section('content')
<section class="forms">
    <div class="container-fluid">
        <div class="card">
            <div class="card-header mt-2">
                <h3 class="text-center">{{ "Update Order Report"}}</h3>
            </div>
            {{-- <div class="row mb-3">
                <div class="col-md-3 offset-md-1 mt-3">
                    <div class="form-group row">
                        <label class="d-tc mt-2"><strong>{{__('file.Choose Your Date')}}</strong> &nbsp;</label>
                       <div class="d-tc w-75">
                            <div class="input-group">
                                <input type="text" class="daterangepicker-field form-control" value="{{$start_date}} To {{$end_date}}" required />
                                <input type="hidden" id="start_date" name="start_date" value="{{$start_date}}" />
                                <input type="hidden" id= "end_date" name="end_date" value="{{$end_date}}" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 mt-3">
                    <div class="form-group row">
                        <label class="d-tc mt-2"><strong>{{__('file.Choose Supplier')}}</strong> &nbsp;</label>
                        <div class="d-tc w-75">
                            <select id="supplier_id" name="supplier_id" class="selectpicker form-control" data-live-search="true" data-live-search-style="begins" >
                                @foreach($lims_supplier_list as $supplier)
                                <option value="{{$supplier->id}}">{{$supplier->title}}</option>

                                @endforeach
                            </select>
                        </div>
                    </div>
                </div>
                <div class="col-md-2" style="margin-top: 3rem !important;">
                    <div class="form-group">
                        <button class="btn btn-primary" id="product_order_quantity" type="submit">{{__('file.submit')}}</button>
                    </div>
                </div>
                <div class="col-md-2" style="margin-top: 3rem !important;">
                    <div class="form-group">
                        <a href="{{ route('report.OrderqtyLists') }}" class="btn btn-primary" id="product_order_quantity">
                            View Draft Orders
                        </a>
                    </div>
                </div>
            </div> --}}
        </div>
    </div>
    <div class="table-responsive">
        <table id="product-report-table" class="table table-hover" style="width: 100%">
            <thead>
                <tr>
                    <th>{{ __('Code') }}</th>
                    <th>{{ __('file.Product') }}</th>
                    <th >{{ __('file.category') }}</th>
                    <th class="text-center">{{ __('file.Sold') }} {{ __('file.qty') }}</th>
                    <th class="text-center">{{ __('file.In Stock') }}</th>
                    <th class="text-center">{{ "Order Qty" }}</th>
                </tr>
            </thead>



            {{-- <tfoot class="tfoot active">
                <th></th>
                <th>{{__('file.Total')}}</th>
                <th></th>
                <th></th>
                <th></th>
            </tfoot> --}}
        </table>
        <button id="submitOrderTable" style="margin-left: 19px;" class="btn btn-primary">Update Orders</button>

    </div>
</section>



@endsection

@push('scripts')
<script type="text/javascript">
    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    });


    $('#btn-export').on('click', function(){
        const startDate = $(".product-report-filter input[name=start_date]").val();
        const endDate = $(".product-report-filter input[name=end_date]").val();

        const url = $(this).attr('data-href');

        // Build URL with query parameters
        const fullUrl = `${url}?starting_date=${encodeURIComponent(startDate)}&ending_date=${encodeURIComponent(endDate)}`;

        // Trigger download
        window.location.href = fullUrl;
    });

    var supplier_id = <?php echo json_encode($supplier_id)?>;
     var date = <?php echo json_encode($start_date)?>;
    $('.product-report-filter select[name="supplier_id"]').val(supplier_id);
    $('.selectpicker').selectpicker('refresh');

    $(".daterangepicker-field").daterangepicker({
      callback: function(startDate, endDate, period){
        var start_date = startDate.format('YYYY-MM-DD');
        var end_date = endDate.format('YYYY-MM-DD');
        var title = start_date + ' To ' + end_date;
        $(this).val(title);
        $(".product-report-filter input[name=start_date]").val(start_date);
        $(".product-report-filter input[name=end_date]").val(end_date);

        console.log($(".product-report-filter input[name=start_date]").val(), end_date)
      }
    });

    var table = $('#product-report-table').DataTable({
        processing: true,
        autoWidth: false,
        serverSide: true,
         ajax: {
            url: "product-order-draft-edite",
            type: "GET",
            data: function (d) {
                d.supplier_id = supplier_id;
                d.start_date = date;
                d.end_date = date;
            }
        },

      columns: [
            {"data": "code"},
            {"data": "name"},
            {"data": "category"},
            {"data": "sold_qty"},
            {"data": "in_stock"},
            {
                data: 'order_qty',
                render: function (data, type, row, meta) {
                    return `
                        <input type="number" class="form-control order-qty-input" data-row="${meta.row}" value="${data}">
                        <input type="hidden" class="form-control order-id-input" data-row="${meta.row}" value="${row.id}">
                        <input type="hidden" class="form-control order-product_id-input" data-row="${meta.row}" value="${row.product_id}">
                        <input type="hidden" class="form-control order-date-input" data-row="${meta.row}" value="${row.date}">
                        <input type="hidden" class="form-control order-supplier-input" data-row="${meta.row}" value="${row.supplier_id}">
                    `;
                }
            },

            {
                data: null,
                orderable: false,
                searchable: false,
                render: function () {
                    return `<button class="btn btn-sm btn-danger delete-row-tabel"><i class="fa fa-trash"></i></button>`;
                }
            }
        ],


        order:[['1', 'desc']],
        columnDefs: [
            {
                targets: [5],
                orderable: false,
                searchable: false
            }
        ],
        lengthMenu: [[50, 100, 500], [50, 100, 500]],
        dom: '<"row"lfB>rtip',
        buttons: [
            {
                extend: 'pdf',
                text: '<i title="export to pdf" class="fa fa-file-pdf-o"></i>',
                exportOptions: {
                    columns: ':visible:Not(.not-exported)',
                    rows: ':visible',
                    format: {
                        body: function (data, row, column, node) {
                            if ($(node).find('input').length > 0) {
                                return $(node).find('input').val(); // input value return
                            }
                            return data;
                        }
                    }
                },
            },
            {
                extend: 'excel',
                text: '<i title="export to excel" class="dripicons-document-new"></i>',
                exportOptions: {
                    columns: ':visible:not(.not-exported)',
                    // rows: ':visible',
                    rows: function (idx, data, node) {
                        return !$(node).hasClass('d-none');
                    },
                    // columns: [0, 1, 2],
                    format: {
                        body: function (data, row, column, node) {
                            if ($(node).find('input').length > 0) {
                                return $(node).find('input').val(); // input value return
                            }

                            return data;
                        }
                    }
                },
            },
            {
                extend: 'csv',
                text: '<i title="export to csv" class="fa fa-file-text-o"></i>',
                exportOptions: {
                    columns: ':visible:not(.not-exported)',
                    rows: ':visible',

                    format: {
                        body: function(data, row, column, node) {
                            if (column === 0) {
                                data = String(data);
                                data = data.split("<br/>").join("\n");
                            }
                            if (column === 2) {
                                data = String(data);
                                data = data.split("<br/>").join("\n");
                            }
                            if ($(node).find('input').length > 0) {
                                return $(node).find('input').val(); // input value return
                            }
                            return data ?? "";
                        }
                    }
                },
            },
            {
                extend: 'print',
                text: '<i title="print" class="fa fa-print"></i>',
                exportOptions: {
                    columns: ':visible:not(.not-exported)',
                    rows: ':visible',
                    format: {
                        body: function (data, row, column, node) {
                            if ($(node).find('input').length > 0) {
                                return $(node).find('input').val(); // input value return
                            }
                            return data;
                        }
                    }
                },
            },
            {
                extend: 'colvis',
                text: '<i title="column visibility" class="fa fa-eye"></i>',
                columns: ':gt(0)'
            },
        ],
    } );

    $('#submitOrderTable').on('click', function () {
    let tableData = [];

    $('#product-report-table tbody tr').not('.d-none').each(function () {
        const row = $(this);
        const name = row.find('td:eq(0)').text().trim();
        const category = row.find('td:eq(1)').text().trim();
        const sold_qty = row.find('td:eq(2)').text().trim();
        const in_stock = row.find('td:eq(3)').text().trim();
        const order_qty = row.find('.order-qty-input').val();
        const product_id = row.find('.order-product_id-input').val();
        const id = row.find('.order-id-input').val();
        const supplier_id = row.find('.order-supplier-input').val();
        const date = row.find('.order-date-input').val();

        tableData.push({
            name,
            id,
            product_id,
            supplier_id,
            date,
            category,
            sold_qty,
            in_stock,
            order_qty,
        });
      });

        $.ajax({
            url: 'product-order-draft-update',
            type: 'POST',
            data: {
                _token: $('meta[name="csrf-token"]').attr('content'),
                orders: tableData,
            },
            success: function (response) {
                alert('Order submitted successfully!');

                const url = 'product-order-list';
                window.open(url, '_blank');
                console.log(response);
            },
            error: function (xhr) {
                alert('Submission failed!');
                console.error(xhr.responseText);
            }
        });
    });



    $('#product_order_quantity').on('click', function () {
        table.ajax.reload();
    });
    $(document).on('input', '.order-qty-input', function () {
        let row = $(this).data('row');
        let newVal = $(this).val();
        console.log(`Row ${row} new Order Qty: ${newVal}`);
    });
    $(document).on('click', '.delete-row-tabel', function () {
        $(this).closest('tr').addClass('d-none');
    });
// });

</script>
@endpush
