<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="icon" type="image/png" href="{{url('logo', $general_setting->site_logo)}}" />
    <title>{{$general_setting->site_title}}</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="all,follow">
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Volkhov:ital,wght@0,400;0,700;1,400;1,700&display=swap" rel="stylesheet">

    <style type="text/css">
        * {
            font-size: 14px;
            line-height: 24px;
            font-family: 'Ubuntu', sans-serif;
            text-transform: capitalize;
        }
        .volkhov-bold {
          font-family: "Volkhov", serif;
          font-weight: 700;
          font-style: normal;
        }
        .btn {
            padding: 7px 10px;
            text-decoration: none;
            border: none;
            display: block;
            text-align: center;
            margin: 7px;
            cursor:pointer;
        }

        .btn-info {
            background-color: #999;
            color: #FFF;
        }

        .btn-primary {
            background-color: #6449e7;
            color: #FFF;
            width: 100%;
        }
        td,
        th,
        tr,
        table {
            border-collapse: collapse;
        }
        tr {border-bottom: 1px dotted #ddd;}
        td,th {padding: 7px 0;}

        table {width: 100%;}
        tfoot tr th:first-child {text-align: left;}

        .centered {
            text-align: center;
            align-content: center;
        }
        small{font-size:12px;}

        @media print {
            * {
                font-size:12px;
                line-height: 20px;
            }
            td,th {padding: 5px 0;}
            .hidden-print {
                display: none !important;
            }
            @page { margin: 1.5cm 0.5cm 0.5cm; }
            @page:first { margin-top: 0.5cm; }
            /*tbody::after {
                content: ''; display: block;
                page-break-after: always;
                page-break-inside: avoid;
                page-break-before: avoid;
            }*/
        }
        
        .bill-data th{
         width: 18%;
        }
        .bill-data td{
         width: 30%;
        }
    </style>
    
    
  </head>
<body>

<div style="max-width:290px;margin:0 auto">
    @if(preg_match('~[0-9]~', url()->previous()))
        @php $url = '../../pos'; @endphp
    @else
        @php $url = url()->previous(); @endphp
    @endif
    <div class="hidden-print">
        <table>
            <tr>
                <td><a href="{{$redirectUrl}}" class="btn btn-info"><i class="fa fa-arrow-left"></i> {{__('file.Back')}}</a> </td>
                <td><button onclick="window.print();" class="btn btn-primary"><i class="dripicons-print"></i> {{__('file.Print')}}</button></td>
            </tr>
        </table>
        <br>
    </div>

    <div id="receipt-data">
        <div class="centered">
            @if($general_setting->site_logo)
                <img src="{{url('logo', $general_setting->site_logo)}}" height="42" width="auto" style="margin: 0px 0;">
            @endif
            <h2 class="volkhov-bold" style="font-size: 24px;margin: 0;margin-top:10px;">{{$general_setting->site_title}}</h2>

            <p class="noto-serif-bengali-700" style="margin: 0;margin-top: 5px;">
                {{$lims_warehouse_data->address}}
                <br>{{$lims_warehouse_data->phone}}
            </p>
        </div>
        @php
            $last_payment_data = $lims_payment_data->last(); // Get the last payment data
        @endphp
        
        <table class="table-data bill-data" style="margin-top:10px;">
            <tbody>
                <tr style="border-top: 1px dotted #ddd; border-bottom: 0px;">
                    <td style="font-size:12px;text-align:left;padding: 4px 0;" @if($lims_sale_data->sale_type != 'pos') colspan="2" @endif>
                        Bill No: {{ str_replace('posr-', '', $lims_sale_data->reference_no) }}
                    </td>
                    @if($lims_sale_data->sale_type == 'pos')
                    <td style="font-size:12px;text-align:right;padding: 4px 0;">
                        @php
                            $nameArray = $lims_sale_data->sale_type == 'pos' ? explode(' ', $lims_biller_data?->name) : ['Website'];
                        @endphp
                        Biller: {{ count($nameArray) > 2 ? $nameArray[0] . ' ' . $nameArray[1] : $nameArray[0] }}
                    </td>
                    @endif
                </tr>
                <tr style="border-bottom: 0px;">
                    <td style="font-size:12px;text-align:left;padding: 4px 0;">
                        {{ trans('file.Date') }}: {{ date($general_setting->date_format, strtotime($lims_sale_data->created_at->toDateString())) }}
                    </td>
                    <td style="font-size:12px;text-align:right;padding: 4px 0;">
                        {{ trans('file.Paid By') }}: {{ $last_payment_data->paying_method ?? 'Cash On Delivery' }}
                    </td>
                </tr>
                <tr>
                    <td style="font-size:12px;text-align:left;padding: 4px 0;border-top: 0px;" colspan="2">
                        {{trans('file.customer')}}: {{$lims_customer_data->name}} @if($lims_customer_data->name != 'Walk In Customer') ({{$lims_customer_data->phone_number}}) @endif
                    </td>
                </tr>
            </tbody>
        </table>

        
        <table class="table-data">
            <thead>
                <tr>
                    <th width="55%" style="font-size:12px;text-align:left;vertical-align:middle;">Product</th>
                    <th width="15%" style="font-size:12px;text-align:center;vertical-align:middle;">Qty</th>
                    <th width="10%" style="font-size:12px;text-align:center;vertical-align:middle;">Rate</th>
                    <th width="20%" style="font-size:12px;text-align:right;vertical-align:middle;">Total</th>
                </tr>
            </thead>
            <tbody>
                <?php $total_product_tax = 0;?>
                @foreach($lims_product_sale_data as $key => $product_sale_data)
                <?php
                    $lims_product_data = \App\Models\Product::find($product_sale_data->product_id);
                    if($product_sale_data->variant_id) {
                        $variant_data = \App\Models\Variant::find($product_sale_data->variant_id);
                        $product_name = $lims_product_data->name.' ['.$variant_data->name.']';
                    }
                    elseif($product_sale_data->product_batch_id) {
                        $product_batch_data = \App\Models\ProductBatch::select('batch_no')->find($product_sale_data->product_batch_id);
                        $product_name = $lims_product_data->name.' ['.trans("file.Batch No").':'.$product_batch_data->batch_no.']';
                    }
                    else
                        $product_name = $lims_product_data->name;

                    // if($product_sale_data->imei_number && !str_contains($product_sale_data->imei_number, "null") ) {
                    //     $product_name .= '<br>'.trans('IMEI or Serial Numbers').': '.$product_sale_data->imei_number;
                    // }
                ?>
                <tr>
                    <td style="font-size:12px;">
                        {!!$product_name!!}
                    </td>
                    <td style="font-size:12px;text-align:center;vertical-align:middle;" width="auto">
                        {{$product_sale_data->qty}} {{\App\Models\Unit::where('id', $product_sale_data->sale_unit_id)->first()->unit_code}}
                    </td>
                    <td style="font-size:12px;text-align:center;vertical-align:middle;">
                        {{number_format((float)($product_sale_data->total / $product_sale_data->qty), $general_setting->decimal, '.', ',')}}
                    </td>
                    <td style="font-size:12px;text-align:right;vertical-align:middle;">{{number_format((float)($product_sale_data->total), $general_setting->decimal, '.', ',')}}</td>
                </tr>
                @endforeach

            <!-- <tfoot> -->
                <tr>
                    <th colspan="3" style="font-size:12px;text-align:right;padding: 4px 0;">{{trans('file.Total')}}</th>
                    <th colspan="3" style="font-size:12px;text-align:right;padding: 4px 0;">{{number_format((float)($lims_sale_data->total_price), $general_setting->decimal, '.', ',')}}</th>
                </tr>
                
                @if($lims_sale_data->order_discount)
                <tr>
                    <th colspan="3" style="font-size:12px;text-align:right;padding: 4px 0;">{{trans('file.Order Discount')}}</th>
                    <th colspan="3" style="font-size:12px;text-align:right;padding: 4px 0;">{{number_format((float)($lims_sale_data->order_discount), $general_setting->decimal, '.', ',')}}</th>
                </tr>
                @endif
                
                @if($lims_sale_data->shipping_cost)
                <tr>
                    <th colspan="3" style="font-size:12px;text-align:right;padding: 4px 0;">{{trans('file.Shipping Cost')}}</th>
                    <th colspan="3" style="font-size:12px;text-align:right;padding: 4px 0;">{{number_format((float)($lims_sale_data->shipping_cost), $general_setting->decimal, '.', ',')}}</th>
                </tr>
                @endif
                <tr>
                    <th colspan="3" style="font-size:12px;text-align:right;padding: 4px 0;">{{trans('file.grand total')}}</th>
                    <th colspan="3" style="font-size:12px;text-align:right;padding: 4px 0;">{{number_format((float)($lims_sale_data->grand_total), $general_setting->decimal, '.', ',')}}</th>
                </tr>
                @foreach($lims_payment_data as $payment_data)
                <tr>
                    <th colspan="3" style="font-size:12px;text-align:right;padding: 4px 0;">{{trans('file.Amount')}}</th>
                    <th colspan="3" style="font-size:12px;text-align:right;padding: 4px 0;">{{number_format((float)($payment_data->amount), $general_setting->decimal, '.', ',')}}</th>
                </tr>
                @endforeach
                <tr>
                    <th colspan="3" style="font-size:12px;text-align:right;padding: 4px 0;">Reward Points Earned</th>
                    <th colspan="3" style="font-size:12px;text-align:right;padding: 4px 0;">{{  }}</th>
                </tr>
            </tbody>
        </table>
        <table>
            <tbody>
                <tr><td class="centered" colspan="3" style="font-size:12px;text-align:center">{{__('file.Thank you for shopping with us. Please come again')}}</td></tr>
                <tr><td class="centered" colspan="3" style="font-size:12px;text-align:center; border-bottom: 0;">{{__('Powered By: Tech Rajshahi Limited')}}</td></tr>
            </tbody>
        </table>
    </div>
</div>

<script type="text/javascript">
    localStorage.clear();
    function auto_print() {
        window.print();
    }
    //setTimeout(auto_print, 1000);
</script>

</body>
</html>
