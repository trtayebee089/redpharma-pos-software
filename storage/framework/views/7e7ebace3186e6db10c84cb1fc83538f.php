<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Welcome to Red Pharma BD</title>
</head>
<body style="font-family: Arial, sans-serif; background-color: #f6f6f6; margin:0; padding:0;">
    <table width="100%" cellpadding="0" cellspacing="0" style="padding:20px;">
        <tr>
            <td align="center">
                <table width="600" cellpadding="0" cellspacing="0" style="background-color:#fff; border-radius:12px; padding:20px;">
                    <!-- Logo -->
                    <tr>
                        <td align="center" style="padding:25px; background:linear-gradient(90deg, #ffd7d7, #e0ffe0);">
                            <img src="https://www.redpharmabd.com/assets/logo-DQC7WR4c.png" alt="Red Pharma Logo"
                                width="170"
                                style="display:block; border:0; filter: drop-shadow(0px 2px 4px rgba(0,0,0,0.3));" />
                        </td>
                    </tr>

                    <!-- Welcome Message -->
                    <tr>
                        <td style="text-align:center; padding:10px 20px;">
                            <h2 style="color:#b30000;">Welcome to Red Pharma BD!</h2>
                            <p style="font-size:16px; color:#333;">Your account has been successfully created.</p>
                        </td>
                    </tr>

                    <!-- Account Details -->
                    <tr>
                        <td style="padding:20px; text-align:center; background-color:#f8fff8; border-radius:8px;">
                            <p style="font-size:16px; color:#333; margin:5px 0;">Username:</p>
                            <p style="font-size:20px; color:#b30000; font-weight:bold; margin:5px 0;"><?php echo e($phone_number); ?></p>

                            <p style="font-size:16px; color:#333; margin:5px 0;">Password:</p>
                            <p style="font-size:20px; color:#b30000; font-weight:bold; margin:5px 0;"><?php echo e($password); ?></p>
                        </td>
                    </tr>

                    <!-- Footer -->
                    <tr>
                        <td style="text-align:center; padding:20px; font-size:14px; color:#777;">
                            <p style="margin:0;">Please keep your credentials safe and do not share them with anyone.</p>
                            <p style="margin:0;">&copy; 2024 Red Pharma BD. All rights reserved.</p>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>
<?php /**PATH C:\xampp\htdocs\01-TR-LARAVEL\redpharma-pos-software\resources\views/mail/registration_confirmation.blade.php ENDPATH**/ ?>