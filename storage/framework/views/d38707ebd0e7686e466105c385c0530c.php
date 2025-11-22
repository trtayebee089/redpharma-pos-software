

<?php if(in_array('ecommerce', explode(',', $general_setting->modules))): ?>
    <?php $__env->startPush('css'); ?>
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
    <?php $__env->stopPush(); ?>
<?php endif; ?>

<?php $__env->startSection('content'); ?>
    <section class="content">
        <div class="container-fluid">

            
            <div class="row g-3">
                
                <div class="col-md-6">
                    <div class="card shadow-sm border-primary">
                        <div class="card-header bg-primary text-white d-flex align-items-center justify-content-between">
                            <div><i class="fas fa-receipt me-2"></i> Order Summary</div>
                            <div class="d-flex">
                                <select name="order_status" id="order_status" class="form-control"
                                    data-orderid="<?php echo e($sale->id); ?>">
                                    <option <?php if($sale?->tracking->current_status == 'pending'): ?> selected <?php endif; ?> value="pending">Pending
                                    </option>
                                    <option <?php if($sale?->tracking->current_status == 'processing'): ?> selected <?php endif; ?> value="processing">Processing
                                    </option>
                                    <option <?php if($sale?->tracking->current_status == 'in_transit'): ?> selected <?php endif; ?> value="in_transit">In Transit
                                    </option>
                                    <option <?php if($sale?->tracking->current_status == 'delivered'): ?> selected <?php endif; ?> value="delivered">Delivered
                                    </option>
                                </select>

                                <a href="<?php echo e(route('sale.invoice', $sale->id)); ?>?redirect=<?php echo e(url()->current()); ?>" class="btn btn-info ml-3"><i class="fa fa-copy"></i><?php echo e(trans('file.Generate Invoice')); ?></a>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <p><strong>Reference No:</strong> <?php echo e(strtoupper($sale->reference_no)); ?></p>
                                <p><strong>Tracking Code:</strong> <?php echo e($sale->tracking->tracking_no ?? '-'); ?></p>
                            </div>
                            <div class="d-flex justify-content-between align-items-center">
                                <p>
                                    <strong>Sale Status:</strong>
                                    <?php
                                        $statusColors = ['warning', 'success', 'danger', 'info'];
                                        $statusText = ['pending', 'completed', '', 'delivered'];
                                    ?>
                                    <span class="badge bg-<?php echo e($statusColors[$sale->sale_status] ?? 'secondary'); ?>">
                                        <?php echo e(ucfirst($statusText[$sale->sale_status])); ?>

                                    </span>
                                </p>
                                <p>
                                    <strong>Payment Status:</strong>
                                    <?php
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
                                    ?>
                                    <span class="badge bg-<?php echo e($paymentColors[$sale->payment_status] ?? 'secondary'); ?>">
                                        <?php echo e($paymentStatus[$sale->payment_status] ?? 'Unknown'); ?>

                                    </span>
                                </p>
                            </div>
                            <div class="d-flex justify-content-between align-items-center">
                                <p><strong>Total:</strong> <span
                                        class="text-success fw-bold"><?php echo e(number_format($sale->grand_total, 2)); ?></span></p>
                                <p><strong>Paid:</strong> <span
                                        class="text-info fw-bold"><?php echo e(number_format($sale->paid_amount, 2)); ?></span></p>
                            </div>
                            <p><strong>Created At:</strong> <?php echo e($sale->created_at->format('d M Y H:i')); ?></p>
                        </div>
                    </div>
                </div>

                
                <div class="col-md-6">
                    <div class="card shadow-sm border-success">
                        <div class="card-header bg-success text-white d-flex justify-content-between align-items-center">
                            <span><i class="fas fa-user me-2"></i> Customer Details</span>
                            <?php if(!$sale->tracking->rider): ?>
                                <button class="btn btn-sm btn-light text-success" data-toggle="modal"
                                    data-target="#assignRiderModal">
                                    <i class="fas fa-plus-circle me-1"></i> Assign Rider
                                </button>
                            <?php endif; ?>
                        </div>
                        <div class="card-body">
                            <p><strong>Name:</strong> <?php echo e($sale->customer->name); ?></p>
                            <div class="d-flex justify-content-between align-items-center">
                                <p><strong>Phone:</strong> <a
                                        href="tel:<?php echo e($sale->customer->phone_number); ?>"><?php echo e($sale->customer->phone_number); ?></a>
                                </p>
                                <p><strong>Email:</strong> <a
                                        href="mailto:<?php echo e($sale->customer->email); ?>"><?php echo e($sale->customer->email ?? '-'); ?></a>
                                </p>
                            </div>
                            <p><strong>Address:</strong> <?php echo e($sale->customer->address ?? '-'); ?></p>
                            <hr>
                            <p class="m-0 text-dark fs-18">
                                <strong>Rider:</strong>
                                <?php if($sale?->tracking?->rider): ?>
                                    <span class="text-primary"><?php echo e($sale->tracking->rider->full_name); ?>

                                        (<?php echo e($sale->tracking->rider->phone); ?>)</span>
                                <?php else: ?>
                                    <span class="text-muted">Not assigned</span>
                                <?php endif; ?>
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            
            <div id="assignRiderModal" tabindex="-1" role="dialog" aria-labelledby="assignRiderModal" aria-hidden="true"
                class="modal fade text-left">
                <div role="document" class="modal-dialog" style="max-width: 500px!important;">
                    <div class="modal-content">
                        <form action="<?php echo e(route('admin.online-sale.assign-rider')); ?>" method="POST">
                            <?php echo csrf_field(); ?>
                            <div class="modal-header">
                                <h5 class="modal-title" id="assignRiderModalLabel">Assign Rider</h5>
                                <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span
                                        aria-hidden="true"><i class="dripicons-cross"></i></span></button>
                            </div>
                            <div class="modal-body">
                                <div class="mb-3">
                                    <label for="rider_id" class="form-label">Select Rider</label>
                                    <input type="hidden" name="order_id" value="<?php echo e($sale->id); ?>">
                                    <select class="form-select" name="rider_id" id="rider_id" required>
                                        <option value="">-- Select Rider --</option>
                                        <?php $__currentLoopData = $riders; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $rider): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                            <option value="<?php echo e($rider->id); ?>"><?php echo e($rider->full_name); ?>

                                                (<?php echo e($rider->phone); ?>)
                                            </option>
                                        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
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
                                    <?php $__currentLoopData = $sale->productSales; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $index => $item): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                        
                                        <tr>
                                            <td><?php echo e($index + 1); ?></td>
                                            <td class="d-flex align-items-center">
                                                <?php echo e($item->name); ?>

                                            </td>
                                            <td><?php echo e($item->imei_number ?? $item->code); ?></td>
                                            <td><?php echo e($item->pivot->qty); ?></td>
                                            <td><?php echo e(number_format($item->pivot->net_unit_price, 2)); ?></td>
                                            <td><?php echo e(number_format($item->pivot->total, 2)); ?></td>
                                        </tr>
                                    <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            
            <div class="row">
                <div class="col-12">
                    <div class="card shadow-sm">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <span>Tracking History</span>
                        </div>
                        <div class="card-body">
                            <?php if($sale->tracking->histories->isEmpty()): ?>
                                <p>No tracking history available.</p>
                            <?php else: ?>
                                <ul class="list-group">
                                    <?php $__currentLoopData = $sale->tracking->histories; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $tracking): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                        <li class="list-group-item d-flex justify-content-between align-items-center">
                                            <span class="text-muted"><?php echo e($tracking->status); ?></span>
                                            <span class="text-muted"><?php echo e($tracking->note ?? '-'); ?></span>
                                            <span
                                                class="text-muted"><?php echo e(\Carbon\Carbon::parse($tracking->created_at)->format('d M Y H:i')); ?></span>
                                        </li>
                                    <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                </ul>
                            <?php endif; ?>
                        </div>
                    </div>
                </div>
            </div>

            
            <div class="modal fade" id="addTrackingModal" tabindex="-1" aria-labelledby="addTrackingModalLabel"
                aria-hidden="true">
                <div class="modal-dialog">
                    <form action="" method="POST">
                        <?php echo csrf_field(); ?>
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
                                        <?php $__currentLoopData = $riders; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $rider): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                            <option value="<?php echo e($rider->id); ?>"><?php echo e($rider->name); ?></option>
                                        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
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
<?php $__env->stopSection(); ?>

<?php $__env->startPush('scripts'); ?>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        $(document).ready(function() {
            $('#order_status').on('change', function(event) {
                event.preventDefault();

                const orderId = $(this).data('orderid');
                const newStatus = $(this).val();

                $.ajax({
                    url: '<?php echo e(route('admin.online-sale.update-status')); ?>',
                    type: 'POST',
                    data: {
                        _token: '<?php echo e(csrf_token()); ?>',
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
<?php $__env->stopPush(); ?>

<?php echo $__env->make('backend.layout.main', \Illuminate\Support\Arr::except(get_defined_vars(), ['__data', '__path']))->render(); ?><?php /**PATH C:\xampp\htdocs\01-TR-LARAVEL\redpharma\resources\views/backend/online-sale/show.blade.php ENDPATH**/ ?>