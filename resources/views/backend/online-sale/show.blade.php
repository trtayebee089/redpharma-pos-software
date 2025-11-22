@extends('backend.layout.main')

@if (in_array('ecommerce', explode(',', $general_setting->modules)))
    @push('css')
        <style>
            .card {
                margin-bottom: 20px;
            }

            .card-header {
                font-weight: bold;
                font-size: 1.1rem;
            }

            .product-img {
                max-width: 60px;
                margin-right: 10px;
            }

            .tracking-status {
                font-size: 0.9rem;
            }
        </style>
    @endpush
@endif

@section('content')
    <section class="content">
        <div class="container-fluid">

            {{-- 1st Row: Order Summary & Customer Details --}}
            <div class="row g-3">
                {{-- Order Summary --}}
                <div class="col-md-6">
                    <div class="card shadow-sm border-primary">
                        <div class="card-header bg-primary text-white d-flex align-items-center justify-content-between">
                            <div><i class="fas fa-receipt me-2"></i> Order Summary</div>
                            <div class="d-flex">
                                <select name="order_status" id="order_status" class="form-control"
                                    data-orderid="{{ $sale->id }}">
                                    <option @if ($sale?->tracking->current_status == 'pending') selected @endif value="pending">Pending
                                    </option>
                                    <option @if ($sale?->tracking->current_status == 'processing') selected @endif value="processing">Processing
                                    </option>
                                    <option @if ($sale?->tracking->current_status == 'in_transit') selected @endif value="in_transit">In Transit
                                    </option>
                                    <option @if ($sale?->tracking->current_status == 'delivered') selected @endif value="delivered">Delivered
                                    </option>
                                </select>

                                <a href="{{route('sale.invoice', $sale->id)}}?redirect={{ url()->current() }}" class="btn btn-info ml-3"><i class="fa fa-copy"></i>{{trans('file.Generate Invoice')}}</a>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <p><strong>Reference No:</strong> {{ strtoupper($sale->reference_no) }}</p>
                                <p><strong>Tracking Code:</strong> {{ $sale->tracking->tracking_no ?? '-' }}</p>
                            </div>
                            <div class="d-flex justify-content-between align-items-center">
                                <p>
                                    <strong>Sale Status:</strong>
                                    @php
                                        $statusColors = ['warning', 'success', 'danger', 'info'];
                                        $statusText = ['pending', 'completed', '', 'delivered'];
                                    @endphp
                                    <span class="badge bg-{{ $statusColors[$sale->sale_status] ?? 'secondary' }}">
                                        {{ ucfirst($statusText[$sale->sale_status]) }}
                                    </span>
                                </p>
                                <p>
                                    <strong>Payment Status:</strong>
                                    @php
                                        $paymentStatus = [
                                            0 => 'Pending',
                                            1 => 'Paid',
                                            2 => 'Partial',
                                            3 => 'Due',
                                        ];
                                        $paymentColors = [
                                            0 => 'warning',
                                            1 => 'success',
                                            2 => 'info',
                                            3 => 'danger',
                                        ];
                                    @endphp
                                    <span class="badge bg-{{ $paymentColors[$sale->payment_status] ?? 'secondary' }}">
                                        {{ $paymentStatus[$sale->payment_status] ?? 'Unknown' }}
                                    </span>
                                </p>
                            </div>
                            <div class="d-flex justify-content-between align-items-center">
                                <p><strong>Total:</strong> <span
                                        class="text-success fw-bold">{{ number_format($sale->grand_total, 2) }}</span></p>
                                <p><strong>Paid:</strong> <span
                                        class="text-info fw-bold">{{ number_format($sale->paid_amount, 2) }}</span></p>
                            </div>
                            <p><strong>Created At:</strong> {{ $sale->created_at->format('d M Y H:i') }}</p>
                        </div>
                    </div>
                </div>

                {{-- Customer Details --}}
                <div class="col-md-6">
                    <div class="card shadow-sm border-success">
                        <div class="card-header bg-success text-white d-flex justify-content-between align-items-center">
                            <span><i class="fas fa-user me-2"></i> Customer Details</span>
                            @if (!$sale->tracking->rider)
                                <button class="btn btn-sm btn-light text-success" data-toggle="modal"
                                    data-target="#assignRiderModal">
                                    <i class="fas fa-plus-circle me-1"></i> Assign Rider
                                </button>
                            @endif
                        </div>
                        <div class="card-body">
                            <p><strong>Name:</strong> {{ $sale->customer->name }}</p>
                            <div class="d-flex justify-content-between align-items-center">
                                <p><strong>Phone:</strong> <a
                                        href="tel:{{ $sale->customer->phone_number }}">{{ $sale->customer->phone_number }}</a>
                                </p>
                                <p><strong>Email:</strong> <a
                                        href="mailto:{{ $sale->customer->email }}">{{ $sale->customer->email ?? '-' }}</a>
                                </p>
                            </div>
                            <p><strong>Address:</strong> {{ $sale->customer->address ?? '-' }}</p>
                            <hr>
                            <p class="m-0 text-dark fs-18">
                                <strong>Rider:</strong>
                                @if ($sale?->tracking?->rider)
                                    <span class="text-primary">{{ $sale->tracking->rider->full_name }}
                                        ({{ $sale->tracking->rider->phone }})</span>
                                @else
                                    <span class="text-muted">Not assigned</span>
                                @endif
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            {{-- Assign Rider Modal --}}
            <div id="assignRiderModal" tabindex="-1" role="dialog" aria-labelledby="assignRiderModal" aria-hidden="true"
                class="modal fade text-left">
                <div role="document" class="modal-dialog" style="max-width: 500px!important;">
                    <div class="modal-content">
                        <form action="{{ route('admin.online-sale.assign-rider') }}" method="POST">
                            @csrf
                            <div class="modal-header">
                                <h5 class="modal-title" id="assignRiderModalLabel">Assign Rider</h5>
                                <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span
                                        aria-hidden="true"><i class="dripicons-cross"></i></span></button>
                            </div>
                            <div class="modal-body">
                                <div class="mb-3">
                                    <label for="rider_id" class="form-label">Select Rider</label>
                                    <input type="hidden" name="order_id" value="{{ $sale->id }}">
                                    <select class="form-select" name="rider_id" id="rider_id" required>
                                        <option value="">-- Select Rider --</option>
                                        @foreach ($riders as $rider)
                                            <option value="{{ $rider->id }}">{{ $rider->full_name }}
                                                ({{ $rider->phone }})
                                            </option>
                                        @endforeach
                                    </select>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-success">Assign</button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>


            {{-- 2nd Row: Products List --}}
            <div class="row">
                <div class="col-12">
                    <div class="card shadow-sm">
                        <div class="card-header">Products Ordered</div>
                        <div class="card-body p-0">
                            <table class="table table-striped mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th>#</th>
                                        <th>Product</th>
                                        <th>SKU / IMEI</th>
                                        <th>Quantity</th>
                                        <th>Unit Price</th>
                                        <th>Subtotal</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach ($sale->productSales as $index => $item)
                                        {{-- @dd($item->pivot->toArray()) --}}
                                        <tr>
                                            <td>{{ $index + 1 }}</td>
                                            <td class="d-flex align-items-center">
                                                {{ $item->name }}
                                            </td>
                                            <td>{{ $item->imei_number ?? $item->code }}</td>
                                            <td>{{ $item->pivot->qty }}</td>
                                            <td>{{ number_format($item->pivot->net_unit_price, 2) }}</td>
                                            <td>{{ number_format($item->pivot->total, 2) }}</td>
                                        </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            {{-- 3rd Row: Tracking History --}}
            <div class="row">
                <div class="col-12">
                    <div class="card shadow-sm">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <span>Tracking History</span>
                        </div>
                        <div class="card-body">
                            @if ($sale->tracking->histories->isEmpty())
                                <p>No tracking history available.</p>
                            @else
                                <ul class="list-group">
                                    @foreach ($sale->tracking->histories as $tracking)
                                        <li class="list-group-item d-flex justify-content-between align-items-center">
                                            <span class="text-muted">{{ $tracking->status }}</span>
                                            <span class="text-muted">{{ $tracking->note ?? '-' }}</span>
                                            <span
                                                class="text-muted">{{ \Carbon\Carbon::parse($tracking->created_at)->format('d M Y H:i') }}</span>
                                        </li>
                                    @endforeach
                                </ul>
                            @endif
                        </div>
                    </div>
                </div>
            </div>

            {{-- Modal to Add New Tracking --}}
            <div class="modal fade" id="addTrackingModal" tabindex="-1" aria-labelledby="addTrackingModalLabel"
                aria-hidden="true">
                <div class="modal-dialog">
                    <form action="" method="POST">
                        @csrf
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="addTrackingModalLabel">Add Tracking Update</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="mb-3">
                                    <label for="status" class="form-label">Status</label>
                                    <select class="form-select" name="status" id="status" required>
                                        <option value="processing">Processing</option>
                                        <option value="in-transit">In-Transit</option>
                                        <option value="delivered">Delivered</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="rider_id" class="form-label">Rider</label>
                                    <select class="form-select" name="rider_id" id="rider_id">
                                        <option value="">-- Select Rider --</option>
                                        @foreach ($riders as $rider)
                                            <option value="{{ $rider->id }}">{{ $rider->name }}</option>
                                        @endforeach
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="note" class="form-label">Note</label>
                                    <textarea class="form-control" name="note" id="note" rows="2"></textarea>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-success">Add</button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>
@endsection

@push('scripts')
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        $(document).ready(function() {
            $('#order_status').on('change', function(event) {
                event.preventDefault();

                const orderId = $(this).data('orderid');
                const newStatus = $(this).val();

                $.ajax({
                    url: '{{ route('admin.online-sale.update-status') }}',
                    type: 'POST',
                    data: {
                        _token: '{{ csrf_token() }}',
                        order_id: orderId,
                        status: newStatus,
                    },
                    success: function(response) {
                        if (response.success) {
                            Swal.fire({
                                icon: 'success',
                                title: 'Success',
                                text: response.message,
                                timer: 1800,
                                showConfirmButton: false,
                                toast: true,
                                position: 'top-end',
                                willClose: () => {
                                    window.location.reload();
                                }
                            })
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Failed',
                                text: response.message,
                                toast: true,
                                position: 'top-end'
                            });
                        }
                    },
                    error: function(xhr) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'Something went wrong while updating status.',
                            toast: true,
                            position: 'top-end'
                        });
                    }
                });
            });
        });
    </script>
@endpush
