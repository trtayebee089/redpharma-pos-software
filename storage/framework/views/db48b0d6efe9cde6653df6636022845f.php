

<?php $__env->startSection('content'); ?>
    <?php if(session()->has('message')): ?>
        <div class="alert alert-success alert-dismissible text-center">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                    aria-hidden="true">&times;</span></button><?php echo e(session()->get('message')); ?>

        </div>
    <?php endif; ?>
    <?php if(session()->has('not_permitted')): ?>
        <div class="alert alert-danger alert-dismissible text-center">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                    aria-hidden="true">&times;</span></button><?php echo e(session()->get('not_permitted')); ?>

        </div>
    <?php endif; ?>

    <div class="container-fluid mt-3">
        <a href="#add-zone" data-toggle="modal" class="btn btn-info add-sale-btn">
            <i class="dripicons-plus"></i> Add New Zone
        </a>
        <a href="<?php echo e(url('sales/sale_by_csv')); ?>" class="btn btn-primary add-sale-btn">
            <i class="dripicons-copy"></i> Export Zone List
        </a>

        <div class="card mt-3">
            <div class="card-body">
                <table id="shippingZoneTable" class="table table-bordered table-striped" style="width: 100%!important;">
                    <thead>
                        <tr>
                            <th class="text-center">Division</th>
                            <th class="text-center">District</th>
                            <th class="text-center">Thana</th>
                            <th class="text-center">Rate (Tk)</th>
                            <th class="text-center">Delivery</th>
                            <th class="text-center">Delivery Partner</th>
                            <th class="text-center">Status</th>
                            <th class="text-center" width="120">Actions</th>
                        </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>

    <!-- Add Zone Modal -->
    <div class="modal fade" id="add-zone" tabindex="-1" role="dialog" aria-labelledby="addZoneLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <form id="addZoneForm" method="POST" action="<?php echo e(route('shipping_zone.store')); ?>">
                <?php echo csrf_field(); ?>
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addZoneLabel">Add New Shipping Zone</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body">
                        <!-- Division -->
                        <div class="form-group">
                            <label for="division">Division</label>
                            <select class="form-control" name="division" id="division" required>
                                <option value="">Select Division</option>
                                <option value="Dhaka">Dhaka</option>
                                <option value="Chattogram">Chattogram</option>
                                <option value="Khulna">Khulna</option>
                                <option value="Rajshahi">Rajshahi</option>
                                <option value="Barishal">Barishal</option>
                                <option value="Sylhet">Sylhet</option>
                                <option value="Rangpur">Rangpur</option>
                                <option value="Mymensingh">Mymensingh</option>
                            </select>
                        </div>

                        <!-- District -->
                        <div class="form-group">
                            <label for="district">District</label>
                            <select class="form-control" name="district" id="district" required>
                                <option value="">Select District</option>
                            </select>
                        </div>

                        <!-- Default Rate -->
                        <div class="form-group">
                            <label for="default_rate">Default Rate (Tk)</label>
                            <input type="number" class="form-control" name="default_rate" id="default_rate" min="0"
                                step="1">
                        </div>

                        <!-- Apply to all Thanas -->
                        <div class="form-check mb-3">
                            <input type="checkbox" class="form-check-input" id="apply_default_rate" checked
                                name="apply_default_rate">
                            <label class="form-check-label" for="apply_default_rate">
                                Apply this rate to all Police Stations/Thana
                            </label>
                        </div>

                        <!-- Thana -->
                        <div class="form-group" id="thana-container" style="display: none;">
                            <label for="thana">Thana / Police Station</label>
                            <input type="text" class="form-control" name="thana" id="thana">
                        </div>

                        <!-- Estimated Delivery -->
                        <div class="form-group">
                            <label for="estimated_delivery">Estimated Delivery</label>
                            <input type="text" class="form-control" name="estimated_delivery"
                                id="estimated_delivery">
                        </div>

                        <!-- Delivery Partner -->
                        <div class="form-group">
                            <label for="delivery_partner">Delivery Partner</label>
                            <select class="form-control" name="delivery_partner" id="delivery_partner" required>
                                <option value="">Select Partner</option>
                                <option value="rider">Own Rider</option>
                                <option value="steadfast">SteadFast</option>
                                <option value="pathao">Pathao</option>
                                <option value="redx">RedX</option>
                            </select>
                        </div>

                        <!-- Active -->
                        <div class="form-group form-check">
                            <input type="checkbox" class="form-check-input" name="is_active" id="is_active" checked>
                            <label class="form-check-label" for="is_active">Active</label>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Add Zone</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
<?php $__env->stopSection(); ?>

<?php $__env->startPush('scripts'); ?>
    <script>
        $(document).ready(function() {
            const shippingZoneTable = $('#shippingZoneTable').DataTable({
                processing: true,
                serverSide: true,
                ajax: '<?php echo e(route('shipping_zone.shippingLoad')); ?>',
                columns: [{
                        data: 'division',
                        name: 'division'
                    },
                    {
                        data: 'district',
                        name: 'district'
                    },
                    {
                        data: 'thana',
                        name: 'thana'
                    },
                    {
                        data: 'rate',
                        name: 'rate',
                        className: 'text-center'
                    },
                    {
                        data: 'estimated_delivery',
                        name: 'estimated_delivery',
                        className: 'text-center'
                    },
                    {
                        data: 'delivery_partner',
                        name: 'delivery_partner',
                        className: 'text-center'
                    },
                    {
                        data: 'is_active',
                        name: 'is_active',
                        orderable: false,
                        searchable: false,
                        className: 'text-center'
                    },
                    {
                        data: 'actions',
                        name: 'actions',
                        orderable: false,
                        searchable: false,
                        className: 'text-center'
                    },
                ]
            });

            const divisionMap = {
                "Dhaka": ["Dhaka", "Faridpur", "Gazipur", "Gopalganj", "Kishoreganj", "Madaripur", "Manikganj",
                    "Munshiganj", "Narsingdi", "Narayanganj", "Tangail"
                ],
                "Chattogram": ["Chattogram", "Bandarban", "Brahmanbaria", "Cumilla", "Cox's Bazar", "Feni",
                    "Khagrachhari", "Lakshmipur", "Noakhali", "Rangamati"
                ],
                "Khulna": ["Bagerhat", "Chuadanga", "Jashore", "Jhenaidah", "Khulna", "Kushtia", "Magura",
                    "Meherpur", "Narail", "Satkhira"
                ],
                "Rajshahi": ["Bogura", "Joypurhat", "Naogaon", "Natore", "Chapainawabganj", "Pabna", "Rajshahi",
                    "Sirajganj"
                ],
                "Barishal": ["Barguna", "Barishal", "Bhola", "Jhalokathi", "Patuakhali", "Pirojpur"],
                "Sylhet": ["Habiganj", "Moulvibazar", "Sunamganj", "Sylhet"],
                "Rangpur": ["Dinajpur", "Gaibandha", "Kurigram", "Lalmonirhat", "Nilphamari", "Panchagarh",
                    "Thakurgaon", "Rangpur", "Kishoreganj"
                ],
                "Mymensingh": ["Jamalpur", "Mymensingh", "Netrokona", "Sherpur"]
            };

            const divisionSelect = document.getElementById('division');
            const districtSelect = document.getElementById('district');
            const applyDefaultRateCheckbox = document.getElementById('apply_default_rate');
            const thanaContainer = document.getElementById('thana-container');

            divisionSelect.addEventListener('change', function() {
                const division = this.value;
                districtSelect.innerHTML = '<option value="">Select District</option>';

                if (division && divisionMap[division]) {
                    divisionMap[division].forEach(district => {
                        const option = document.createElement('option');
                        option.value = district;
                        option.textContent = district;
                        districtSelect.appendChild(option);
                    });
                }

                $(districtSelect).selectpicker('refresh');
            });

            applyDefaultRateCheckbox.addEventListener('change', function() {
                if (this.checked) {
                    thanaContainer.style.display = 'none';
                } else {
                    thanaContainer.style.display = 'block';
                }
            });

            if (!applyDefaultRateCheckbox.checked) {
                thanaContainer.style.display = 'block';
            }

            $('#addZoneForm').submit(function(e) {
                e.preventDefault();
                const form = $(this);
                $.ajax({
                    url: form.attr('action'),
                    method: 'POST',
                    data: form.serialize(),
                    success: function(response) {
                        $('#add-zone').modal('hide');
                        $('#shippingZoneTable').DataTable().ajax.reload();
                        alert('Shipping zone added successfully!');
                    },
                    error: function(xhr) {
                        alert('Failed to add zone. Please check the fields.');
                    }
                });
            });

            $(document).on('click', '.deleteZone', function(e) {
                e.preventDefault();

                let zoneId = $(this).data('id');
                if (!zoneId) return;

                if (!confirm('Are you sure you want to delete this shipping zone?')) return;

                $.ajax({
                    url: "<?php echo e(route('shipping_zone.delete')); ?>",
                    type: 'DELETE',
                    data: {
                        _token: $('meta[name="csrf-token"]').attr('content'),
                        id: zoneId
                    },
                    success: function(response) {
                        if (response.status) {
                            alert(response.message);
                            shippingZoneTable.ajax.reload();
                        } else {
                            alert('Failed to delete zone.');
                        }
                    },
                    error: function(xhr) {
                        console.error(xhr.responseText);
                        alert('An error occurred while deleting.');
                    }
                });
            });

        });
    </script>
<?php $__env->stopPush(); ?>

<?php echo $__env->make('backend.layout.main', \Illuminate\Support\Arr::except(get_defined_vars(), ['__data', '__path']))->render(); ?><?php /**PATH C:\xampp\htdocs\01-TR-LARAVEL\redpharma\resources\views/backend/setting/shipping_zones.blade.php ENDPATH**/ ?>