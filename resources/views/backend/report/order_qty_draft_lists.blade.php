@extends('backend.layout.main') @section('content')
<section class="forms">
    <div class="container-fluid">
        <div class="card">
            <div class="card-header mt-2">
                <h3 class="text-center">{{ "Order Draft Report"}}</h3>
            </div>
            <div class="row mb-3">
                {{-- <div class="col-md-3 offset-md-1 mt-3">
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
                </div> --}}
                {{-- <div class="col-md-3 mt-3">
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
                </div> --}}
                {{-- <div class="col-md-2" style="margin-top: 3rem !important;">
                    <div class="form-group">
                        <button class="btn btn-primary" id="product_order_quantity" type="submit">{{__('file.submit')}}</button>
                    </div>
                </div>
                <div class="col-md-2" style="margin-top: 3rem !important;">

                    <div class="form-group">
                        <button class="btn btn-primary" id="product_order_quantity" type="submit">{{"View Draft Orders"}}</button>
                    </div>
                </div> --}}
                    {{-- <div class="col-md-3" style="margin-top: 3rem !important;">
                        <div class="form-group">
                            <button class="btn btn-primary" id="product_order_quantity" type="submit">{{"View Draft Orders"}}</button>
                        </div>
                    </div> --}}
                {{-- </div> --}}
            </div>
        </div>
    </div>
    <div class="table-responsive">
        <table id="product-report-table" class="table table-hover" style="width: 100%">
            <thead>
                <tr>
                    <th>{{ __('Supplier Name') }}</th>
                    <th >{{ __('Date') }}</th>
                    <th>{{ "Order Qty" }}</th>
                    <th>Action</th>
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
        {{-- <button id="submitOrderTable" class="btn btn-primary">Submit Orders</button> --}}

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

    var start_date = $(".product-report-filter input[name=start_date]").val();
    var end_date = $(".product-report-filter input[name=end_date]").val();
    var supplier_id = $(".product-report-filter select[name=supplier_id]").val();
    var supplier_id1 = $('#supplier_id').val();
    var start_date1 = $('#start_date').val();
    var end_date1 = $('#end_date').val();

    var table = $('#product-report-table').DataTable({
    processing: true,
    autoWidth: false,
    serverSide: true,
    ajax: {
        url: "product-order-list-data",
        type: "GET",
        data: function (d) {
            d.supplier_id = $('#supplier_id').val();
            d.start_date = $('#start_date').val();
            d.end_date = $('#end_date').val();
        }
    },
    columns: [
        { data: "brand_name" },
        { data: "formatted_date" },
        { data: "order_qty" },
        {
            data: null,
            orderable: false,
            searchable: false,
            render: function (data, type, row) {
                return `
                    <button
                        class="btn btn-sm btn-info view-order-btn"
                        data-supplier-id="${row.supplier_id}"
                        data-date="${row.date}">
                        View
                    </button>
                    <button
                        class="btn btn-sm btn-danger delete-order-btn"
                        data-supplier-id="${row.supplier_id}"
                        data-date="${row.date}">
                        Delete
                    </button>
                `;
            }
        }
    ],
    order: [[1, 'desc']],
    columnDefs: [
        {
            orderable: false,
            targets: [3]
        }
    ],
    lengthMenu: [[50, 100, 500], [50, 100, 500]],
    dom: '<"row"lfB>rtip',
    buttons: [
        {
            extend: 'pdf',
            text: '<i title="Export to PDF" class="fa fa-file-pdf-o"></i>',
            exportOptions: {
                columns: ':visible:not(.not-exported)',
                rows: ':visible',
                format: {
                    body: function (data, row, column, node) {
                        if ($(node).find('input').length > 0) {
                            return $(node).find('input').val();
                        }
                        return data;
                    }
                }
            }
        },
        {
            extend: 'excel',
            text: '<i title="Export to Excel" class="dripicons-document-new"></i>',
            exportOptions: {
                columns: ':visible:not(.not-exported)',
                rows: function (idx, data, node) {
                    return !$(node).hasClass('d-none');
                },
                format: {
                    body: function (data, row, column, node) {
                        if ($(node).find('input').length > 0) {
                            return $(node).find('input').val();
                        }
                        return data;
                    }
                }
            }
        },
        {
            extend: 'csv',
            text: '<i title="Export to CSV" class="fa fa-file-text-o"></i>',
            exportOptions: {
                columns: ':visible:not(.not-exported)',
                rows: ':visible',
                format: {
                    body: function(data, row, column, node) {
                        if ($(node).find('input').length > 0) {
                            return $(node).find('input').val();
                        }
                        return data ?? "";
                    }
                }
            }
        },
        {
            extend: 'print',
            text: '<i title="Print" class="fa fa-print"></i>',
            exportOptions: {
                columns: ':visible:not(.not-exported)',
                rows: ':visible',
                format: {
                    body: function (data, row, column, node) {
                        if ($(node).find('input').length > 0) {
                            return $(node).find('input').val();
                        }
                        return data;
                    }
                }
            }
        },
        {
            extend: 'colvis',
            text: '<i title="Column visibility" class="fa fa-eye"></i>',
            columns: ':gt(0)'
        }
    ]
});


// Button click handler
// $(document).on('click', '.view-order-btn', function () {
//     const supplierId = $(this).data('supplier-id');
//     const date = $(this).data('date');
//     const url = 'product-order-draft-lists';
//     window.open(url, '_blank'); // or use window.location.href = url;
// });

$(document).on('click', '.view-order-btn', function () {
    const supplierId = $(this).data('supplier-id');
    const date = $(this).data('date');
    const params = new URLSearchParams({
        supplier_id: supplierId,
        date: date
    });

    const url = `product-order-draft-lists?${params.toString()}`;
    window.open(url, '_blank'); // Or: window.location.href = url;
});


$(document).on('click', '.delete-order-btn', function () {
    const supplierId = $(this).data('supplier-id');
    const date = $(this).data('date');

    if (!confirm('Are you sure you want to delete this draft order?')) return;

    $.ajax({
        url: `product-order/delete?supplier_id=${supplierId}&date=${date}`,
        type: 'DELETE',
        data: {
            _token: $('meta[name="csrf-token"]').attr('content')
        },
        success: function (response) {
            alert(response.message || 'Deleted successfully');
            $('#product-report-table').DataTable().ajax.reload(null, false);
        },
        error: function (xhr) {
            alert('Delete failed: ' + (xhr.responseJSON?.message || 'Something went wrong.'));
        }
    });
});



    $('#submitOrderTable').on('click', function () {
        let tableData = [];

        $('#product-report-table tbody tr').each(function () {
            const row = $(this);

            const name = row.find('td:eq(0)').text().trim(); // name column
            const category = row.find('td:eq(1)').text().trim(); // category column
            const sold_qty = row.find('td:eq(2)').text().trim(); // sold_qty
            const in_stock = row.find('td:eq(3)').text().trim(); // in_stock
            const order_qty = row.find('.order-qty-input').val(); // input field
            const product_id = row.find('.order-id-input').val(); // input field

            var start_date = $(".product-report-filter input[name=start_date]").val();
            var end_date = $(".product-report-filter input[name=end_date]").val();
            var supplier_id = $(".product-report-filter select[name=supplier_id]").val();
            var supplier_id1 = $('#supplier_id').val();
            var start_date1 = $('#start_date').val();
            var end_date1 = $('#end_date').val();

            tableData.push({
                name,
                product_id,
                category,
                sold_qty,
                in_stock,
                order_qty,
            });
        });

        // Submit via AJAX
        $.ajax({
            url: 'product-order-report-data-entry',
            type: 'POST',
            data: {
                _token: $('meta[name="csrf-token"]').attr('content'),
                orders: tableData,
                supplierId:supplier_id ?? supplier_id1,
                startDate:start_date ?? start_date1,
                endDate:end_date ?? end_date1,
            },
            success: function (response) {
                alert('Order submitted successfully!');
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
