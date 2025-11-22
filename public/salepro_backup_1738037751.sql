

CREATE TABLE `accounts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `account_no` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `initial_balance` double DEFAULT NULL,
  `total_balance` double NOT NULL,
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `is_default` tinyint(1) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Bank Account',
  `parent_account_id` int DEFAULT NULL,
  `is_payment` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO accounts VALUES("1","11111","Sales Accounts","1000","1000","this is first account","1","1","2018-12-18 08:58:02","2024-03-12 13:57:50","","Bank Account","","1");
INSERT INTO accounts VALUES("3","21211","Sa","","0","","0","1","2018-12-18 08:58:56","2019-01-20 15:59:06","","Bank Account","","1");
INSERT INTO accounts VALUES("5","bank-1","zuhair","100000","100000","","","1","2022-11-28 11:58:18","2022-11-28 11:58:18","","Bank Account","","1");



CREATE TABLE `adjustments` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `warehouse_id` int NOT NULL,
  `document` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_qty` double NOT NULL,
  `item` int NOT NULL,
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `attendances` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `employee_id` int NOT NULL,
  `user_id` int NOT NULL,
  `checkin` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `checkout` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` int NOT NULL,
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `barcodes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `width` double(22,4) DEFAULT NULL,
  `height` double(22,4) DEFAULT NULL,
  `paper_width` double(22,4) DEFAULT NULL,
  `paper_height` double(22,4) DEFAULT NULL,
  `top_margin` double(22,4) DEFAULT NULL,
  `left_margin` double(22,4) DEFAULT NULL,
  `row_distance` double(22,4) DEFAULT NULL,
  `col_distance` double(22,4) DEFAULT NULL,
  `stickers_in_one_row` int DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `is_continuous` tinyint(1) NOT NULL DEFAULT '0',
  `stickers_in_one_sheet` int DEFAULT NULL,
  `is_custom` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO barcodes VALUES("1","20 Labels per Sheet","Sheet Size: 8.5" x 11", Label Size: 4" x 1", Label...","4.0000","1.0000","8.5000","11.0000","0.5000","0.1250","0.0000","0.1875","2","0","0","20","","","");
INSERT INTO barcodes VALUES("2","30 Labels per sheet","Sheet Size: 8.5" x 11", Label Size: 2.625" x 1", Labels per sheet: 30","2.6250","1.0000","8.5000","11.0000","0.5000","0.1880","0.0000","0.1250","3","0","0","30","","","");
INSERT INTO barcodes VALUES("3","32 Labels per sheet","Sheet Size: 8.5" x 11", Label Size: 2" x 1.25", Labels per sheet: 32","2.0000","1.2500","8.5000","11.0000","0.5000","0.2500","0.0000","0.0000","4","0","0","32","","","");
INSERT INTO barcodes VALUES("4","40 Labels per sheet","Sheet Size: 8.5" x 11", Label Size: 2" x 1", Labels per sheet: 40","2.0000","1.0000","8.5000","11.0000","0.5000","0.2500","0.0000","0.0000","4","0","0","40","","","");
INSERT INTO barcodes VALUES("5","50 Labels per Sheet","Sheet Size: 8.5" x 11", Label Size: 1.5" x 1", Labels per sheet: 50","1.5000","1.0000","8.5000","11.0000","0.5000","0.5000","0.0000","0.0000","5","0","0","50","","","");
INSERT INTO barcodes VALUES("6","Continuous Rolls - 31.75mm x 25.4mm","Label Size: 31.75mm x 25.4mm, Gap: 3.18mm","1.2500","1.0000","1.2500","0.0000","0.1250","0.0000","0.1250","0.0000","1","0","1","","","","");
INSERT INTO barcodes VALUES("7","custom","","2.0000","0.5000","3.0000","10.0000","2.0000","2.0000","0.3000","0.3000","1","0","0","28","1","","2025-01-27 15:38:17");



CREATE TABLE `billers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `vat_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postal_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO billers VALUES("1","John Watson","","The solution","","john@gmail.com","312313","36 housing road","london","","","England","1","2024-01-19 19:30:23","2024-01-19 19:30:23");
INSERT INTO billers VALUES("2","William Bradshaw","","Todd and Gaines Inc","36","munizad@mailinator.com","+(880) 1782-063170","Deserunt provident","Nisi excepturi fugia","Voluptate dolorum no","","Rerum similique dese","1","2025-01-12 13:08:02","2025-01-12 13:08:02");
INSERT INTO billers VALUES("3","Cynthia Roman","20250123023012.png","Lyons Mitchell Associates","431","powazyti@mailinator.com","+1 (968) 642-9489","Fugit debitis deser","Tenetur est numquam","Recusandae Animi q","Ea ut reprehenderit","Do omnis error quibu","0","2025-01-23 14:29:55","2025-01-23 14:30:23");



CREATE TABLE `boutiques` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `brand_id` int unsigned NOT NULL,
  `account_id` int unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO boutiques VALUES("1","8","1","Huels and Sons","Wintheiser-Weimann","(239) 536-8689","schowalter.katelin@example.net","TAX925","Brazil","Minnesota","West Tess","4249 Wehner Rapid Suite 727
Erinfort, DE 42044","1","2025-01-25 11:15:26","2025-01-25 11:15:26");
INSERT INTO boutiques VALUES("4","8","1","Collins Ltd","Morar-Zemlak","+1-585-236-5660","sandrine41@example.com","TAX691","Netherlands Antilles","Massachusetts","Wildermanhaven","819 Arlie Rapid
East Thelma, PA 55666","1","2025-01-25 11:15:26","2025-01-25 11:15:26");
INSERT INTO boutiques VALUES("5","1","5","Hyatt-Marvin","Sipes Inc","(740) 207-4201","alberta.ohara@example.com","TAX498","Canada","Colorado","South Juvenal","62747 Alfredo Ports
Abagailburgh, NE 80995-1768","1","2025-01-25 11:15:26","2025-01-25 11:15:26");
INSERT INTO boutiques VALUES("6","1","3","Gwendolyn Noel","Holt Arnold Associates","+1 (322) 805-4767","jifulo@mailinator.com","681","Ut iste et consequat","Chittagong","Consequatur et labo","Fugit ex velit vol","1","2025-01-25 12:53:52","2025-01-25 14:20:56");
INSERT INTO boutiques VALUES("7","10","1","Elton Lowery","Alvarez Everett Co","+1 (395) 195-4397","gesu@mailinator.com","349","Aut ab autem cum dol","Ad ut exercitation d","Ut porro dolor optio","Libero et ad ut blan","1","2025-01-25 15:12:43","2025-01-25 15:12:43");



CREATE TABLE `brands` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO brands VALUES("1","Apple","20240114102326.png","1","2024-01-08 11:25:12","2024-01-14 22:23:26");
INSERT INTO brands VALUES("2","Samsung","20240114102343.png","1","2024-01-08 11:25:12","2024-01-14 22:23:43");
INSERT INTO brands VALUES("3","Huawei","20240114102512.png","1","2024-01-08 11:25:12","2024-01-14 22:25:12");
INSERT INTO brands VALUES("4","Xiaomi","20240114103640.png","1","2024-01-08 11:25:12","2024-01-14 22:36:40");
INSERT INTO brands VALUES("5","Whirlpool","20240114103701.png","1","2024-01-08 11:25:12","2024-01-14 22:37:01");
INSERT INTO brands VALUES("6","Nestle","20240114103717.png","1","2024-01-08 11:25:12","2024-01-14 22:37:17");
INSERT INTO brands VALUES("7","Kraft","20240114103851.png","1","2024-01-08 11:25:12","2024-01-14 22:38:51");
INSERT INTO brands VALUES("8","Kellogs","20240114103906.png","1","2024-01-08 11:25:12","2024-01-14 22:39:06");
INSERT INTO brands VALUES("9","Unilever","20240114103928.png","1","2024-01-08 11:25:12","2024-01-14 22:39:28");
INSERT INTO brands VALUES("10","LG","20240114103943.png","1","2024-01-08 11:25:12","2024-01-14 22:39:43");
INSERT INTO brands VALUES("11","Haier","20240114102407.png","1","2024-01-08 11:25:12","2024-01-14 22:24:07");
INSERT INTO brands VALUES("12","Bosch","20240114103618.png","1","2024-01-08 11:25:12","2024-01-14 22:36:18");
INSERT INTO brands VALUES("13","Siemens","20240114104008.png","1","2024-01-08 11:25:12","2024-01-14 22:40:08");
INSERT INTO brands VALUES("14","Philips","20240114104027.png","1","2024-01-08 11:25:12","2024-01-14 22:40:27");
INSERT INTO brands VALUES("15","Nike","20240114104052.png","1","2024-01-08 11:25:12","2024-01-14 22:40:52");
INSERT INTO brands VALUES("16","Adidas","20240114104112.png","1","2024-01-08 11:25:12","2024-01-14 22:41:12");
INSERT INTO brands VALUES("17","Canon","20240114034815.png","1","2024-01-14 15:48:15","2024-01-14 15:48:15");
INSERT INTO brands VALUES("18","Omega","20240119071354.jpg","1","2024-01-19 19:13:54","2024-01-19 19:14:59");
INSERT INTO brands VALUES("19","jhakanaka","","1","2024-04-29 18:28:31","2024-04-29 18:28:31");
INSERT INTO brands VALUES("20","Nokia","","1","2025-01-08 14:38:49","2025-01-08 14:38:49");
INSERT INTO brands VALUES("21","Lotto","","1","2025-01-22 12:56:17","2025-01-22 12:56:17");
INSERT INTO brands VALUES("22","Laboriosam est rem","20250123023658.png","0","2025-01-23 14:36:40","2025-01-23 14:37:10");



CREATE TABLE `cash_registers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `cash_in_hand` double NOT NULL,
  `user_id` int NOT NULL,
  `warehouse_id` int NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO cash_registers VALUES("1","100","1","2","0","2024-01-19 20:46:52","2024-08-26 05:03:17");
INSERT INTO cash_registers VALUES("2","150","1","1","0","2024-01-19 20:47:08","2024-08-26 05:03:24");
INSERT INTO cash_registers VALUES("3","200","1","1","1","2024-08-26 05:04:20","2024-08-26 05:04:20");
INSERT INTO cash_registers VALUES("4","10000","9","1","1","2024-12-23 12:09:05","2024-12-23 12:09:05");
INSERT INTO cash_registers VALUES("5","100000","1","2","1","2025-01-08 13:50:19","2025-01-08 13:50:19");



CREATE TABLE `categories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `woocommerce_category_id` int DEFAULT NULL,
  `is_sync_disable` tinyint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO categories VALUES("1","Smartphone & Gadges","","","1","","","2024-01-05 01:22:14","2024-01-08 12:22:02");
INSERT INTO categories VALUES("2","Phone Accessories","","1","1","","","2024-01-05 01:22:14","2024-01-08 12:22:03");
INSERT INTO categories VALUES("3","iPhone","","1","1","","","2024-01-05 01:22:14","2024-01-08 12:22:03");
INSERT INTO categories VALUES("4","Samsung","","1","1","","","2024-01-05 01:22:14","2024-01-08 12:22:03");
INSERT INTO categories VALUES("5","Phone Cases","","1","1","","","2024-01-05 01:22:15","2024-01-08 12:22:03");
INSERT INTO categories VALUES("6","Laptops & Computers","","","1","","","2024-01-05 01:22:15","2024-01-08 12:22:03");
INSERT INTO categories VALUES("7","Keyboards","","6","1","","","2024-01-05 01:22:15","2024-01-08 12:22:03");
INSERT INTO categories VALUES("8","Laptop Bags","","6","1","","","2024-01-05 01:22:15","2024-01-08 12:22:04");
INSERT INTO categories VALUES("9","Mouses","","6","1","","","2024-01-05 01:22:15","2024-01-08 12:22:04");
INSERT INTO categories VALUES("10","Webcams","","6","1","","","2024-01-05 01:22:15","2024-01-08 12:22:04");
INSERT INTO categories VALUES("11","Monitors","","6","1","","","2024-01-05 01:22:15","2024-01-08 12:22:04");
INSERT INTO categories VALUES("12","Smartwatches","","","1","","","2024-01-05 01:22:15","2024-01-08 12:22:04");
INSERT INTO categories VALUES("13","Sport Watches","","12","1","","","2024-01-05 01:22:15","2024-01-08 12:22:05");
INSERT INTO categories VALUES("14","Kids Watches","","12","1","","","2024-01-05 01:22:15","2024-01-08 12:22:05");
INSERT INTO categories VALUES("15","Women Watches","","12","1","","","2024-01-05 01:22:15","2024-01-08 12:22:05");
INSERT INTO categories VALUES("16","Men Watches","","12","1","","","2024-01-05 01:22:15","2024-01-08 12:22:05");
INSERT INTO categories VALUES("17","Appliances","20240117121109.png","","1","","","2024-01-05 01:22:15","2024-01-08 12:22:05");
INSERT INTO categories VALUES("18","Dishwashers","","17","1","","","2024-01-05 01:22:15","2024-01-08 12:22:05");
INSERT INTO categories VALUES("19","Dryers","","17","1","","","2024-01-05 01:22:15","2024-01-08 12:22:05");
INSERT INTO categories VALUES("20","Washing machine","","17","1","","","2024-01-05 01:22:15","2024-01-08 12:22:05");
INSERT INTO categories VALUES("21","Refrigerators","","17","1","","","2024-01-05 01:22:15","2024-01-08 12:22:05");
INSERT INTO categories VALUES("22","Vacuum cleaners","","17","1","","","2024-01-05 01:22:15","2024-01-08 12:22:05");
INSERT INTO categories VALUES("23","TVs, Audio & Video","","","1","","","2024-01-05 01:22:16","2024-01-08 12:22:05");
INSERT INTO categories VALUES("24","Television Accessories","","23","1","","","2024-01-05 01:22:16","2024-01-08 12:22:05");
INSERT INTO categories VALUES("25","HD, DVD Players","","23","1","","","2024-01-05 01:22:16","2024-01-08 12:22:05");
INSERT INTO categories VALUES("26","TV-DVD Combos","","23","1","","","2024-01-05 01:22:16","2024-01-08 12:22:05");
INSERT INTO categories VALUES("27","Projectors","","23","1","","","2024-01-05 01:22:16","2024-01-08 12:22:05");
INSERT INTO categories VALUES("28","Projection Screen","","23","1","","","2024-01-05 01:22:16","2024-01-08 12:22:05");
INSERT INTO categories VALUES("29","Fruits & Vegetables","","","1","","","2024-01-05 01:22:16","2024-01-08 12:22:05");
INSERT INTO categories VALUES("30","Dairy & Egg","","","1","","","2024-01-05 01:22:16","2024-01-08 12:22:05");
INSERT INTO categories VALUES("31","Meat & Fish","","","1","","","2024-01-05 01:22:16","2024-01-08 12:22:05");
INSERT INTO categories VALUES("32","Sauces & Pickles","","","0","","","2024-01-05 01:22:16","2024-01-08 12:22:05");
INSERT INTO categories VALUES("33","Candy & Chocolates","","","1","","","2024-01-05 01:22:16","2024-01-08 12:22:05");
INSERT INTO categories VALUES("34","Foods","","","1","","","2024-01-05 01:22:16","2024-01-08 12:22:05");
INSERT INTO categories VALUES("35","Cooking","","34","1","","","2024-01-05 01:22:16","2024-01-08 12:22:05");
INSERT INTO categories VALUES("36","Breakfast","","34","1","","","2024-01-05 01:22:16","2024-01-08 12:22:05");
INSERT INTO categories VALUES("37","Beverages","","34","1","","","2024-01-05 01:22:16","2024-01-08 12:22:05");
INSERT INTO categories VALUES("38","BackPack","20240119070653.jpg","","1","","","","");
INSERT INTO categories VALUES("40","spices","","","1","","","2024-04-29 18:28:15","2024-04-29 18:28:15");
INSERT INTO categories VALUES("41","Electronics","","","1","","","2025-01-08 12:18:38","2025-01-08 12:18:38");
INSERT INTO categories VALUES("42","Mobile","","","1","","","2025-01-08 14:39:23","2025-01-08 14:39:23");
INSERT INTO categories VALUES("43","accessories","","","1","","","2025-01-22 12:56:17","2025-01-22 12:56:17");
INSERT INTO categories VALUES("44","food","","","1","","","2025-01-22 16:01:22","2025-01-22 16:01:22");
INSERT INTO categories VALUES("45","Sports","","","1","","","2025-01-23 13:12:44","2025-01-23 13:12:44");
INSERT INTO categories VALUES("46","Cat1","20250123020753.png","","0","","","2025-01-23 14:04:32","2025-01-23 14:08:26");
INSERT INTO categories VALUES("47","Medicine","","","1","","","2025-01-27 09:45:23","2025-01-27 09:45:23");



CREATE TABLE `challans` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `courier_id` int NOT NULL,
  `packing_slip_list` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount_list` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cash_list` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `online_payment_list` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `cheque_list` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `delivery_charge_list` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status_list` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `closing_date` date DEFAULT NULL,
  `created_by_id` int NOT NULL,
  `closed_by_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO challans VALUES("1","1001","Close","1","1","577","500","","77","50","Delivered","2024-08-11","1","1","2024-08-11 11:27:04","2024-08-11 11:28:06");
INSERT INTO challans VALUES("2","1002","Active","1","2","599","","","","","","","1","","2024-08-11 11:39:22","2024-08-11 11:39:22");



CREATE TABLE `coupons` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` double NOT NULL,
  `minimum_amount` double DEFAULT NULL,
  `quantity` int NOT NULL,
  `used` int NOT NULL,
  `expired_date` date NOT NULL,
  `user_id` int NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `couriers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO couriers VALUES("1","Fedex","3122312","london,uk","1","2024-08-11 11:26:49","2024-08-11 11:26:49");



CREATE TABLE `currencies` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exchange_rate` double NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO currencies VALUES("1","US Dollar","USD","1","1","2020-11-01 06:22:58","2023-04-02 15:51:28");
INSERT INTO currencies VALUES("2","Euro","Euro","0.95","1","2020-11-01 07:29:12","2023-06-08 16:10:32");
INSERT INTO currencies VALUES("3","Bangladeshi Taka","BDT","110","0","2023-09-06 13:05:29","2023-09-06 13:05:46");



CREATE TABLE `custom_fields` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `belongs_to` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `default_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `option_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `grid_value` int NOT NULL,
  `is_table` tinyint(1) NOT NULL,
  `is_invoice` tinyint(1) NOT NULL,
  `is_required` tinyint(1) NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  `is_disable` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `customer_groups` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `percentage` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO customer_groups VALUES("1","Regular","0","1","2024-01-19 19:19:29","2024-01-19 19:19:29");



CREATE TABLE `customers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `customer_group_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tax_no` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postal_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `points` double DEFAULT NULL,
  `deposit` double DEFAULT NULL,
  `expense` double DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `ecom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dsf` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'df',
  `arabic_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admin` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `franchise_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Same as Customer',
  `customer_assigned_to` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Advocate',
  `assigned` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Advocate',
  `aaaaaaaa` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'aa',
  `district` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO customers VALUES("1","1","44","James Bond","MI6","","313131","","221 Baker Street","London","","","England","26","20","0","1","2024-01-19 19:23:29","2024-07-11 12:28:52","","df","","","","Same as Customer","Advocate","Advocate","aa","");
INSERT INTO customers VALUES("2","1","","Walk in Customer","","","231313","","Halishahar","chittagong","","","Bangladesh","442","","","1","2024-01-19 19:31:51","2025-01-27 09:28:42","","df","","","","Same as Customer","Advocate","Advocate","aa","");
INSERT INTO customers VALUES("4","1","46","bkk","","bkk@bkk.com","87897","","jhkjh","gjhgh","","","","","","","1","2024-06-10 16:40:15","2024-06-10 16:40:15","","df","","","","Same as Customer","Advocate","Advocate","aa","");
INSERT INTO customers VALUES("5","1","","Brian James","Willis and Hardin Plc","vadaqyteka@mailinator.com","+1 (737) 222-6586","","Laboris est libero d","Sit nostrud obcaeca","Consectetur sint q","Veniam doloribus de","Assumenda dolor atqu","","","","1","2025-01-23 14:31:22","2025-01-23 14:31:22","","df","","","","Same as Customer","Advocate","Advocate","aa","");



CREATE TABLE `deliveries` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sale_id` int NOT NULL,
  `packing_slip_ids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `courier_id` int DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `delivered_by` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recieved_by` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO deliveries VALUES("1","dr-20240811-112542","42","1","1","1","Halishahar","","","","","3","2024-08-11 11:25:42","2024-08-11 11:28:06");
INSERT INTO deliveries VALUES("2","dr-20240811-113738","43","2","1","1","Halishahar","","","","","2","2024-08-11 11:37:38","2024-08-11 11:39:22");



CREATE TABLE `departments` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO departments VALUES("1","Engineering","1","2025-01-23 14:16:45","2025-01-23 14:16:45");



CREATE TABLE `deposits` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `amount` double NOT NULL,
  `customer_id` int NOT NULL,
  `user_id` int NOT NULL,
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO deposits VALUES("1","20","1","1","","2024-07-08 11:54:31","2024-07-08 11:54:31");



CREATE TABLE `discount_plan_customers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `discount_plan_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO discount_plan_customers VALUES("1","1","1","2024-11-25 16:34:42","2024-11-25 16:34:42");
INSERT INTO discount_plan_customers VALUES("2","1","2","2024-11-25 16:34:42","2024-11-25 16:34:42");
INSERT INTO discount_plan_customers VALUES("3","1","4","2024-11-25 16:34:42","2024-11-25 16:34:42");



CREATE TABLE `discount_plan_discounts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `discount_id` int NOT NULL,
  `discount_plan_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO discount_plan_discounts VALUES("1","1","1","2024-11-25 16:37:03","2024-11-25 16:37:03");



CREATE TABLE `discount_plans` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO discount_plans VALUES("1","Black Friday","1","2024-11-25 16:34:42","2024-11-25 16:34:42");



CREATE TABLE `discounts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `applicable_for` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_list` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `valid_from` date NOT NULL,
  `valid_till` date NOT NULL,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` double NOT NULL,
  `minimum_qty` double NOT NULL,
  `maximum_qty` double NOT NULL,
  `days` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO discounts VALUES("1","Black Friday","All","","2024-11-25","2024-12-31","percentage","10","1","10","Mon,Tue,Wed,Thu,Fri,Sat,Sun","1","2024-11-25 16:37:03","2024-12-18 11:17:22");



CREATE TABLE `dso_alerts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_info` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `number_of_products` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `employees` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `department_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `staff_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO employees VALUES("1","Kato Cherry","kytoq@mailinator.com","+1 (386) 251-8925","1","","Qui cupidatat quis c","20250123022516.jpg","Quo dolor rerum cum","Sint excepteur reic","Dolores omnis ea opt","0","2025-01-23 14:24:43","2025-01-23 14:27:32");



CREATE TABLE `expense_categories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO expense_categories VALUES("1","Electric Bill","Electric Bill","1","2024-01-19 20:50:02","2024-01-19 20:50:02");



CREATE TABLE `expenses` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expense_category_id` int NOT NULL,
  `warehouse_id` int NOT NULL,
  `account_id` int NOT NULL,
  `user_id` int NOT NULL,
  `cash_register_id` int DEFAULT NULL,
  `amount` double NOT NULL,
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `boutique_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `expenses_boutique_id_foreign` (`boutique_id`),
  CONSTRAINT `expenses_boutique_id_foreign` FOREIGN KEY (`boutique_id`) REFERENCES `boutiques` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO expenses VALUES("1","er-20240119-085023","1","1","1","1","2","200","","2024-01-19 20:50:23","2024-01-19 20:50:23","");
INSERT INTO expenses VALUES("2","er-20240119-085046","1","2","1","1","1","120","","2024-01-19 20:50:46","2024-01-19 20:50:46","");
INSERT INTO expenses VALUES("3","er-20240825-063016","1","2","1","1","","450","","2024-08-26 05:30:15","2024-08-26 05:30:16","");
INSERT INTO expenses VALUES("4","er-20250126-125022","1","2","1","1","5","10","","2025-01-26 00:00:00","2025-01-26 12:50:43","1");



CREATE TABLE `external_services` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `module_status` json DEFAULT NULL,
  `active` int DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO external_services VALUES("1","PayPal","payment","Client ID,Client Secret;abcd1234,wxyz5678","{"ecommerce": false}","1","","");
INSERT INTO external_services VALUES("2","Stripe","payment","Public Key,Private Key;efgh1234,stuv5678","{"ecommerce": false}","1","","");
INSERT INTO external_services VALUES("4","Razorpay","payment","Key,Secret;rzp_test_Y4MCcpHfZNU6rR,3Hr7SDqaZ0G5waN0jsLgsiLx","{"salepro": true}","1","2024-12-07 11:50:36","2024-12-07 11:50:36");
INSERT INTO external_services VALUES("5","Paystack","payment","public_Key,Secret_Key;pk_test_e8d220b7463d64569f0053e78534f38e6b10cf4a,sk_test_6d62cb976e1e0ab43f1e48b2934b0dfc7f32a1fe","{"salepro": true}","1","2024-12-07 11:50:36","2024-12-07 11:50:36");
INSERT INTO external_services VALUES("6","Mollie","payment","api_key;test_dHar4XY7LxsDOtmnkVtjNVWXLSlXsM","{"salepro": true}","1","2024-12-07 11:50:36","2024-12-07 11:50:36");
INSERT INTO external_services VALUES("7","Xendit","payment","secret_key,callback_token;xnd_development_aKJVKYbc4lHkEjcCLzWLrBsKs6jF6nbM6WaCMfnJerP3JW57CLis553XNRdDU,YPZxND92Mt8tdXntTYIEkRX802onZ5OcdKBUzycebuqYvN4n","{"salepro": true}","1","2024-12-07 11:50:36","2024-12-07 11:50:36");
INSERT INTO external_services VALUES("8","bkash","payment","Mode,app_key,app_secret,username,password;sandbox,0vWQuCRGiUX7EPVjQDr0EUAYtc,jcUNPBgbcqEDedNKdvE4G1cAK7D3hCjmJccNPZZBq96QIxxwAMEx,01770618567,D7DaC<*E*eG","{"salepro": true}","1","2024-12-07 11:50:36","2024-12-07 11:50:36");
INSERT INTO external_services VALUES("9","sslcommerz","payment","appkey,appsecret;12341234,asdfa23423","{"salepro": true}","1","2024-12-07 11:50:36","2024-12-07 11:50:36");
INSERT INTO external_services VALUES("10","Mpesa","payment","consumer_Key,consumer_Secret;fhfgkj,dtrddhd","{"salepro": true}","1","2024-12-07 11:50:36","2024-12-07 11:50:36");
INSERT INTO external_services VALUES("11","Pesapal","payment","Mode,Consumer Key,Consumer Secret;sandbox,qkio1BGGYAXTu2JOfm7XSXNruoZsrqEW,osGQ364R49cXKeOYSpaOnT++rHs=","{"salepro": true}","1","2024-12-07 11:50:36","2024-12-07 11:50:36");
INSERT INTO external_services VALUES("12","Moneipoint","payment","Mode,client_id,client_secret,terminal_serial;sandbox,api-client-5093949-97bc3ad4-97ff-400c-945e-175f6d6fe716,i!+dNaslg_@PTvaGF89P,P260300316179","{"salepro": true}","1","2024-12-07 11:50:36","2024-12-07 11:50:36");



CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `general_settings` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `site_title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `site_logo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_rtl` tinyint(1) DEFAULT NULL,
  `currency` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `package_id` int DEFAULT NULL,
  `subscription_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `staff_access` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `without_stock` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'no',
  `date_format` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `developed_by` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_format` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `decimal` int DEFAULT '2',
  `state` int DEFAULT NULL,
  `theme` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `modules` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `currency_position` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiry_date` date DEFAULT NULL,
  `expiry_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'days',
  `expiry_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `is_zatca` tinyint(1) DEFAULT NULL,
  `company_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vat_registration_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_packing_slip` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO general_settings VALUES("1","SalePro","20250123024505.png","0","1","","","all","yes","d-m-Y","LionCoders","standard","2","1","default.css","manufacturing","2018-07-06 12:13:11","2025-01-27 16:57:48","prefix","","days","0","0","Lioncoders","98098007","1");



CREATE TABLE `gift_card_recharges` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `gift_card_id` int NOT NULL,
  `amount` double NOT NULL,
  `user_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `gift_cards` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `card_no` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` double NOT NULL,
  `expense` double NOT NULL,
  `customer_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `expired_date` date DEFAULT NULL,
  `created_by` int NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `holidays` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `is_approved` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `hrm_settings` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `checkin` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `checkout` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO hrm_settings VALUES("1","10:00am","6:00pm","2019-01-02 08:20:08","2019-01-02 10:20:53");



CREATE TABLE `income_categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO income_categories VALUES("1","99903833","Foreign investment","1","2024-08-11 10:56:46","2024-08-11 10:56:46");



CREATE TABLE `incomes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `income_category_id` int NOT NULL,
  `warehouse_id` int NOT NULL,
  `account_id` int NOT NULL,
  `user_id` int NOT NULL,
  `cash_register_id` int DEFAULT NULL,
  `amount` double NOT NULL,
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `boutique_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `incomes_boutique_id_foreign` (`boutique_id`),
  CONSTRAINT `incomes_boutique_id_foreign` FOREIGN KEY (`boutique_id`) REFERENCES `boutiques` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO incomes VALUES("2","ir-20250126-122009","1","1","1","1","3","100","","2025-01-14 00:00:00","2025-01-26 12:39:54","");
INSERT INTO incomes VALUES("3","ir-20250126-122422","1","1","1","1","3","100","","2025-01-26 00:00:00","2025-01-26 12:37:58","1");



CREATE TABLE `languages` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO languages VALUES("1","en","2018-07-08 04:59:17","2019-12-24 23:34:20");



CREATE TABLE `mail_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `driver` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `port` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `from_address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `from_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `encryption` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=282 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO migrations VALUES("1","2014_10_12_000000_create_users_table","1");
INSERT INTO migrations VALUES("2","2014_10_12_100000_create_password_resets_table","1");
INSERT INTO migrations VALUES("3","2018_02_17_060412_create_categories_table","1");
INSERT INTO migrations VALUES("4","2018_02_20_035727_create_brands_table","1");
INSERT INTO migrations VALUES("5","2018_02_25_100635_create_suppliers_table","1");
INSERT INTO migrations VALUES("6","2018_02_27_101619_create_warehouse_table","1");
INSERT INTO migrations VALUES("7","2018_03_03_040448_create_units_table","1");
INSERT INTO migrations VALUES("8","2018_03_04_041317_create_taxes_table","1");
INSERT INTO migrations VALUES("9","2018_03_10_061915_create_customer_groups_table","1");
INSERT INTO migrations VALUES("10","2018_03_10_090534_create_customers_table","1");
INSERT INTO migrations VALUES("11","2018_03_11_095547_create_billers_table","1");
INSERT INTO migrations VALUES("12","2018_04_05_054401_create_products_table","1");
INSERT INTO migrations VALUES("13","2018_04_06_133606_create_purchases_table","1");
INSERT INTO migrations VALUES("14","2018_04_06_154600_create_product_purchases_table","1");
INSERT INTO migrations VALUES("15","2018_04_06_154915_create_product_warhouse_table","1");
INSERT INTO migrations VALUES("16","2018_04_10_085927_create_sales_table","1");
INSERT INTO migrations VALUES("17","2018_04_10_090133_create_product_sales_table","1");
INSERT INTO migrations VALUES("18","2018_04_10_090254_create_payments_table","1");
INSERT INTO migrations VALUES("19","2018_04_10_090341_create_payment_with_cheque_table","1");
INSERT INTO migrations VALUES("20","2018_04_10_090509_create_payment_with_credit_card_table","1");
INSERT INTO migrations VALUES("21","2018_04_13_121436_create_quotation_table","1");
INSERT INTO migrations VALUES("22","2018_04_13_122324_create_product_quotation_table","1");
INSERT INTO migrations VALUES("23","2018_04_14_121802_create_transfers_table","1");
INSERT INTO migrations VALUES("24","2018_04_14_121913_create_product_transfer_table","1");
INSERT INTO migrations VALUES("25","2018_05_13_082847_add_payment_id_and_change_sale_id_to_payments_table","2");
INSERT INTO migrations VALUES("26","2018_05_13_090906_change_customer_id_to_payment_with_credit_card_table","3");
INSERT INTO migrations VALUES("27","2018_05_20_054532_create_adjustments_table","4");
INSERT INTO migrations VALUES("28","2018_05_20_054859_create_product_adjustments_table","4");
INSERT INTO migrations VALUES("29","2018_05_21_163419_create_returns_table","5");
INSERT INTO migrations VALUES("30","2018_05_21_163443_create_product_returns_table","5");
INSERT INTO migrations VALUES("31","2018_06_02_050905_create_roles_table","6");
INSERT INTO migrations VALUES("32","2018_06_02_073430_add_columns_to_users_table","7");
INSERT INTO migrations VALUES("33","2018_06_03_053738_create_permission_tables","8");
INSERT INTO migrations VALUES("36","2018_06_21_063736_create_pos_setting_table","9");
INSERT INTO migrations VALUES("37","2018_06_21_094155_add_user_id_to_sales_table","10");
INSERT INTO migrations VALUES("38","2018_06_21_101529_add_user_id_to_purchases_table","11");
INSERT INTO migrations VALUES("39","2018_06_21_103512_add_user_id_to_transfers_table","12");
INSERT INTO migrations VALUES("40","2018_06_23_061058_add_user_id_to_quotations_table","13");
INSERT INTO migrations VALUES("41","2018_06_23_082427_add_is_deleted_to_users_table","14");
INSERT INTO migrations VALUES("42","2018_06_25_043308_change_email_to_users_table","15");
INSERT INTO migrations VALUES("43","2018_07_06_115449_create_general_settings_table","16");
INSERT INTO migrations VALUES("44","2018_07_08_043944_create_languages_table","17");
INSERT INTO migrations VALUES("45","2018_07_11_102144_add_user_id_to_returns_table","18");
INSERT INTO migrations VALUES("46","2018_07_11_102334_add_user_id_to_payments_table","18");
INSERT INTO migrations VALUES("47","2018_07_22_130541_add_digital_to_products_table","19");
INSERT INTO migrations VALUES("49","2018_07_24_154250_create_deliveries_table","20");
INSERT INTO migrations VALUES("50","2018_08_16_053336_create_expense_categories_table","21");
INSERT INTO migrations VALUES("51","2018_08_17_115415_create_expenses_table","22");
INSERT INTO migrations VALUES("55","2018_08_18_050418_create_gift_cards_table","23");
INSERT INTO migrations VALUES("56","2018_08_19_063119_create_payment_with_gift_card_table","24");
INSERT INTO migrations VALUES("57","2018_08_25_042333_create_gift_card_recharges_table","25");
INSERT INTO migrations VALUES("58","2018_08_25_101354_add_deposit_expense_to_customers_table","26");
INSERT INTO migrations VALUES("59","2018_08_26_043801_create_deposits_table","27");
INSERT INTO migrations VALUES("60","2018_09_02_044042_add_keybord_active_to_pos_setting_table","28");
INSERT INTO migrations VALUES("61","2018_09_09_092713_create_payment_with_paypal_table","29");
INSERT INTO migrations VALUES("62","2018_09_10_051254_add_currency_to_general_settings_table","30");
INSERT INTO migrations VALUES("63","2018_10_22_084118_add_biller_and_store_id_to_users_table","31");
INSERT INTO migrations VALUES("65","2018_10_26_034927_create_coupons_table","32");
INSERT INTO migrations VALUES("66","2018_10_27_090857_add_coupon_to_sales_table","33");
INSERT INTO migrations VALUES("67","2018_11_07_070155_add_currency_position_to_general_settings_table","34");
INSERT INTO migrations VALUES("68","2018_11_19_094650_add_combo_to_products_table","35");
INSERT INTO migrations VALUES("69","2018_12_09_043712_create_accounts_table","36");
INSERT INTO migrations VALUES("70","2018_12_17_112253_add_is_default_to_accounts_table","37");
INSERT INTO migrations VALUES("71","2018_12_19_103941_add_account_id_to_payments_table","38");
INSERT INTO migrations VALUES("72","2018_12_20_065900_add_account_id_to_expenses_table","39");
INSERT INTO migrations VALUES("73","2018_12_20_082753_add_account_id_to_returns_table","40");
INSERT INTO migrations VALUES("74","2018_12_26_064330_create_return_purchases_table","41");
INSERT INTO migrations VALUES("75","2018_12_26_144210_create_purchase_product_return_table","42");
INSERT INTO migrations VALUES("76","2018_12_26_144708_create_purchase_product_return_table","43");
INSERT INTO migrations VALUES("77","2018_12_27_110018_create_departments_table","44");
INSERT INTO migrations VALUES("78","2018_12_30_054844_create_employees_table","45");
INSERT INTO migrations VALUES("79","2018_12_31_125210_create_payrolls_table","46");
INSERT INTO migrations VALUES("80","2018_12_31_150446_add_department_id_to_employees_table","47");
INSERT INTO migrations VALUES("81","2019_01_01_062708_add_user_id_to_expenses_table","48");
INSERT INTO migrations VALUES("82","2019_01_02_075644_create_hrm_settings_table","49");
INSERT INTO migrations VALUES("83","2019_01_02_090334_create_attendances_table","50");
INSERT INTO migrations VALUES("84","2019_01_27_160956_add_three_columns_to_general_settings_table","51");
INSERT INTO migrations VALUES("85","2019_02_15_183303_create_stock_counts_table","52");
INSERT INTO migrations VALUES("86","2019_02_17_101604_add_is_adjusted_to_stock_counts_table","53");
INSERT INTO migrations VALUES("87","2019_04_13_101707_add_tax_no_to_customers_table","54");
INSERT INTO migrations VALUES("89","2019_10_14_111455_create_holidays_table","55");
INSERT INTO migrations VALUES("90","2019_11_13_145619_add_is_variant_to_products_table","56");
INSERT INTO migrations VALUES("91","2019_11_13_150206_create_product_variants_table","57");
INSERT INTO migrations VALUES("92","2019_11_13_153828_create_variants_table","57");
INSERT INTO migrations VALUES("93","2019_11_25_134041_add_qty_to_product_variants_table","58");
INSERT INTO migrations VALUES("94","2019_11_25_134922_add_variant_id_to_product_purchases_table","58");
INSERT INTO migrations VALUES("95","2019_11_25_145341_add_variant_id_to_product_warehouse_table","58");
INSERT INTO migrations VALUES("96","2019_11_29_182201_add_variant_id_to_product_sales_table","59");
INSERT INTO migrations VALUES("97","2019_12_04_121311_add_variant_id_to_product_quotation_table","60");
INSERT INTO migrations VALUES("98","2019_12_05_123802_add_variant_id_to_product_transfer_table","61");
INSERT INTO migrations VALUES("100","2019_12_08_114954_add_variant_id_to_product_returns_table","62");
INSERT INTO migrations VALUES("101","2019_12_08_203146_add_variant_id_to_purchase_product_return_table","63");
INSERT INTO migrations VALUES("102","2020_02_28_103340_create_money_transfers_table","64");
INSERT INTO migrations VALUES("103","2020_07_01_193151_add_image_to_categories_table","65");
INSERT INTO migrations VALUES("105","2020_09_26_130426_add_user_id_to_deliveries_table","66");
INSERT INTO migrations VALUES("107","2020_10_11_125457_create_cash_registers_table","67");
INSERT INTO migrations VALUES("108","2020_10_13_155019_add_cash_register_id_to_sales_table","68");
INSERT INTO migrations VALUES("109","2020_10_13_172624_add_cash_register_id_to_returns_table","69");
INSERT INTO migrations VALUES("110","2020_10_17_212338_add_cash_register_id_to_payments_table","70");
INSERT INTO migrations VALUES("111","2020_10_18_124200_add_cash_register_id_to_expenses_table","71");
INSERT INTO migrations VALUES("112","2020_10_21_121632_add_developed_by_to_general_settings_table","72");
INSERT INTO migrations VALUES("113","2019_08_19_000000_create_failed_jobs_table","73");
INSERT INTO migrations VALUES("114","2020_10_30_135557_create_notifications_table","73");
INSERT INTO migrations VALUES("115","2020_11_01_044954_create_currencies_table","74");
INSERT INTO migrations VALUES("116","2020_11_01_140736_add_price_to_product_warehouse_table","75");
INSERT INTO migrations VALUES("117","2020_11_02_050633_add_is_diff_price_to_products_table","76");
INSERT INTO migrations VALUES("118","2020_11_09_055222_add_user_id_to_customers_table","77");
INSERT INTO migrations VALUES("119","2020_11_17_054806_add_invoice_format_to_general_settings_table","78");
INSERT INTO migrations VALUES("120","2021_02_10_074859_add_variant_id_to_product_adjustments_table","79");
INSERT INTO migrations VALUES("121","2021_03_07_093606_create_product_batches_table","80");
INSERT INTO migrations VALUES("122","2021_03_07_093759_add_product_batch_id_to_product_warehouse_table","80");
INSERT INTO migrations VALUES("123","2021_03_07_093900_add_product_batch_id_to_product_purchases_table","80");
INSERT INTO migrations VALUES("124","2021_03_11_132603_add_product_batch_id_to_product_sales_table","81");
INSERT INTO migrations VALUES("127","2021_03_25_125421_add_is_batch_to_products_table","82");
INSERT INTO migrations VALUES("128","2021_05_19_120127_add_product_batch_id_to_product_returns_table","82");
INSERT INTO migrations VALUES("130","2021_05_22_105611_add_product_batch_id_to_purchase_product_return_table","83");
INSERT INTO migrations VALUES("131","2021_05_23_124848_add_product_batch_id_to_product_transfer_table","84");
INSERT INTO migrations VALUES("132","2021_05_26_153106_add_product_batch_id_to_product_quotation_table","85");
INSERT INTO migrations VALUES("133","2021_06_08_213007_create_reward_point_settings_table","86");
INSERT INTO migrations VALUES("134","2021_06_16_104155_add_points_to_customers_table","87");
INSERT INTO migrations VALUES("135","2021_06_17_101057_add_used_points_to_payments_table","88");
INSERT INTO migrations VALUES("136","2021_07_06_132716_add_variant_list_to_products_table","89");
INSERT INTO migrations VALUES("137","2021_09_27_161141_add_is_imei_to_products_table","90");
INSERT INTO migrations VALUES("138","2021_09_28_170052_add_imei_number_to_product_warehouse_table","91");
INSERT INTO migrations VALUES("139","2021_09_28_170126_add_imei_number_to_product_purchases_table","91");
INSERT INTO migrations VALUES("140","2021_10_03_170652_add_imei_number_to_product_sales_table","92");
INSERT INTO migrations VALUES("141","2021_10_10_145214_add_imei_number_to_product_returns_table","93");
INSERT INTO migrations VALUES("142","2021_10_11_104504_add_imei_number_to_product_transfer_table","94");
INSERT INTO migrations VALUES("143","2021_10_12_160107_add_imei_number_to_purchase_product_return_table","95");
INSERT INTO migrations VALUES("144","2021_10_12_205146_add_is_rtl_to_general_settings_table","96");
INSERT INTO migrations VALUES("145","2021_10_23_142451_add_is_approve_to_payments_table","97");
INSERT INTO migrations VALUES("146","2022_01_13_191242_create_discount_plans_table","97");
INSERT INTO migrations VALUES("147","2022_01_14_174318_create_discount_plan_customers_table","97");
INSERT INTO migrations VALUES("148","2022_01_14_202439_create_discounts_table","98");
INSERT INTO migrations VALUES("149","2022_01_16_153506_create_discount_plan_discounts_table","98");
INSERT INTO migrations VALUES("150","2022_02_05_174210_add_order_discount_type_and_value_to_sales_table","99");
INSERT INTO migrations VALUES("154","2022_05_26_195506_add_daily_sale_objective_to_products_table","100");
INSERT INTO migrations VALUES("155","2022_05_28_104209_create_dso_alerts_table","101");
INSERT INTO migrations VALUES("156","2022_06_01_112100_add_is_embeded_to_products_table","102");
INSERT INTO migrations VALUES("157","2022_06_14_130505_add_sale_id_to_returns_table","103");
INSERT INTO migrations VALUES("159","2022_07_19_115504_add_variant_data_to_products_table","104");
INSERT INTO migrations VALUES("160","2022_07_25_194300_add_additional_cost_to_product_variants_table","104");
INSERT INTO migrations VALUES("161","2022_09_04_195610_add_purchase_id_to_return_purchases_table","105");
INSERT INTO migrations VALUES("162","2023_01_18_123842_alter_table_pos_setting","106");
INSERT INTO migrations VALUES("164","2023_01_18_125040_alter_table_general_settings","107");
INSERT INTO migrations VALUES("165","2023_01_18_133701_alter_table_pos_setting","108");
INSERT INTO migrations VALUES("166","2023_01_25_145309_add_expiry_date_to_general_settings_table","109");
INSERT INTO migrations VALUES("167","2023_02_23_125656_alter_table_sales","110");
INSERT INTO migrations VALUES("168","2023_02_26_124100_add_package_id_to_general_settings_table","111");
INSERT INTO migrations VALUES("169","2023_03_04_120325_create_custom_fields_table","111");
INSERT INTO migrations VALUES("170","2023_03_22_174352_add_currency_id_and_exchange_rate_to_returns_table","112");
INSERT INTO migrations VALUES("171","2023_03_27_114320_add_currency_id_and_exchange_rate_to_purchases_table","113");
INSERT INTO migrations VALUES("172","2023_03_27_132747_add_currency_id_and_exchange_rate_to_return_purchases_table","114");
INSERT INTO migrations VALUES("173","2023_04_25_150236_create_mail_settings_table","115");
INSERT INTO migrations VALUES("174","2023_05_13_125424_add_zatca_to_general_settings_table","116");
INSERT INTO migrations VALUES("175","2023_05_28_155540_create_tables_table","117");
INSERT INTO migrations VALUES("176","2023_05_29_115039_add_is_table_to_pos_setting_table","117");
INSERT INTO migrations VALUES("177","2023_05_29_115301_add_table_id_to_sales_table","117");
INSERT INTO migrations VALUES("178","2023_05_31_165049_add_queue_no_to_sales_table","117");
INSERT INTO migrations VALUES("190","2023_08_12_124016_add_staff_id_to_employees_table","121");
INSERT INTO migrations VALUES("192","2023_07_23_160254_create_couriers_table","122");
INSERT INTO migrations VALUES("193","2023_07_23_174343_add_courier_id_to_deliveries_table","122");
INSERT INTO migrations VALUES("194","2023_08_14_142608_add_is_active_to_currencies_table","122");
INSERT INTO migrations VALUES("195","2023_08_24_130203_change_columns_to_attendances_table","122");
INSERT INTO migrations VALUES("196","2023_09_10_134503_add_without_stock_to_general_settings_table","123");
INSERT INTO migrations VALUES("204","2023_09_26_211542_add_modules_to_general_settings_table","125");
INSERT INTO migrations VALUES("217","2023_10_15_124306_add_return_qty_to_product_sales_table","129");
INSERT INTO migrations VALUES("219","2023_12_03_235606_crete_external_services_table","131");
INSERT INTO migrations VALUES("221","2023_03_14_174658_add_subscription_type_to_general_setting_table","130");
INSERT INTO migrations VALUES("222","2024_02_04_131826_add_unit_cost_to_product_adjustments_table","132");
INSERT INTO migrations VALUES("223","2024_02_13_173126_change_modules_to_general_settings_table","133");
INSERT INTO migrations VALUES("224","2024_05_02_114215_add_payment_receiver_to_payments","134");
INSERT INTO migrations VALUES("225","2024_05_06_132553_create_sms_templates_table","135");
INSERT INTO migrations VALUES("226","2024_05_07_102225_add_send_sms_to_pos_setting_table","135");
INSERT INTO migrations VALUES("227","2024_05_07_132625_add_is_default_to_sms_templates_table","135");
INSERT INTO migrations VALUES("228","2024_05_08_112211_change_address_and_city_field_to_nullable_in_customers_table","135");
INSERT INTO migrations VALUES("229","2024_05_08_151050_add_is_default_ecommerce_columne_to_sms_templates_table","135");
INSERT INTO migrations VALUES("230","2024_05_20_182757_add_wholesale_price_to_products_table","136");
INSERT INTO migrations VALUES("231","2024_05_21_170500_add_is_sent_to_transfers_table","137");
INSERT INTO migrations VALUES("232","2023_02_05_132001_add_change_to_payments_table","138");
INSERT INTO migrations VALUES("233","2024_06_04_225113_create_income_categories_table","138");
INSERT INTO migrations VALUES("234","2024_06_04_225128_create_incomes_table","138");
INSERT INTO migrations VALUES("235","2024_06_29_131917_add_is_packing_slip_to_general_settings_table","138");
INSERT INTO migrations VALUES("236","2024_07_05_192531_create_packing_slips_table","138");
INSERT INTO migrations VALUES("237","2024_07_05_193002_create_packing_slip_products_table","138");
INSERT INTO migrations VALUES("238","2024_07_05_194501_add_is_packing_and_delivered_to_product_sales_table","138");
INSERT INTO migrations VALUES("239","2024_07_14_122245_add_delivery_id_to_packing_slips_table","138");
INSERT INTO migrations VALUES("240","2024_07_14_122415_add_variant_id_to_packing_slip_products_table","138");
INSERT INTO migrations VALUES("241","2024_07_14_122519_add_packing_slip_ids_to_deliveries_table","138");
INSERT INTO migrations VALUES("242","2024_07_16_125908_create_challans_table","138");
INSERT INTO migrations VALUES("243","2023_03_09_114030_create_woocommerce_sync_logs_table","139");
INSERT INTO migrations VALUES("244","2023_03_14_114324_create_woocommerce_settings_table","139");
INSERT INTO migrations VALUES("245","2023_03_18_141537_add_woocommerce_category_id_to_categories_table","139");
INSERT INTO migrations VALUES("246","2023_03_20_214553_add_column_for_woocommerce_to_products_table","139");
INSERT INTO migrations VALUES("247","2023_03_20_214563_add_woocommerce_tax_id_to_taxes_table","139");
INSERT INTO migrations VALUES("248","2023_03_20_214565_add_woocommerce_order_id_to_sales_table","139");
INSERT INTO migrations VALUES("249","2023_08_01_134406_add_is_sync_disable_to_categories_table","139");
INSERT INTO migrations VALUES("250","2023_08_01_135252_add_product_status_to_woocommerce_settings_table","139");
INSERT INTO migrations VALUES("251","2024_08_12_112830_add_thermal_invoice_size_to_pos_setting","139");
INSERT INTO migrations VALUES("252","2024_08_14_133351_add_expiry_type_value_to_general_settings","139");
INSERT INTO migrations VALUES("253","2024_09_11_151744_add_return_qty_to_product_purchases_table","140");
INSERT INTO migrations VALUES("254","2024_09_12_162309_create_barcodes_table","140");
INSERT INTO migrations VALUES("255","2024_10_10_121312_add_data_to_payment_with_credit_card_table","141");
INSERT INTO migrations VALUES("256","2024_10_10_212501_alter_attendances_table","142");
INSERT INTO migrations VALUES("257","2024_10_10_213757_alter_attendances_table","142");
INSERT INTO migrations VALUES("258","2024_10_14_144917_change_column_to_nullable_to_payment_with_credit_card_table","142");
INSERT INTO migrations VALUES("259","2024_09_01_120515_create_productions_table","143");
INSERT INTO migrations VALUES("260","2024_09_01_120536_create_product_productions_table","143");
INSERT INTO migrations VALUES("261","2024_11_10_121521_add_code_and_type_to_accounts_table","144");
INSERT INTO migrations VALUES("262","2024_11_24_100926_add_module_status_to_external_services_table","144");
INSERT INTO migrations VALUES("267","2025_01_20_121127_add_warranty_and_guarantee_to_products_table","145");
INSERT INTO migrations VALUES("270","2024_12_10_201131_add_columns_to_tables_table","146");
INSERT INTO migrations VALUES("274","2025_01_25_080916_create_boutiques_table","147");
INSERT INTO migrations VALUES("275","2025_01_25_163041_add_boutique_id_and_name_ar_to_products_table","148");
INSERT INTO migrations VALUES("279","2025_01_26_105619_add_boutique_id_to_incomes_table","149");
INSERT INTO migrations VALUES("281","2025_01_26_124440_add_boutique_id_to_expenses_table","150");



CREATE TABLE `money_transfers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `from_account_id` int NOT NULL,
  `to_account_id` int NOT NULL,
  `amount` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `notifications` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint unsigned NOT NULL,
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO notifications VALUES("c1be2e82-2e18-435a-bed5-f47994bc76fa","App\Notifications\SendNotification","App\Models\User","44","{"sender_id":"1","receiver_id":"44","reminder_date":"2006-07-01","document_name":"20250123023350.png","message":"Est sit distinctio"}","","2025-01-23 14:33:52","2025-01-23 14:33:52");



CREATE TABLE `packing_slip_products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `packing_slip_id` int NOT NULL,
  `product_id` int NOT NULL,
  `variant_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO packing_slip_products VALUES("1","1","23","","2024-08-11 11:25:41","2024-08-11 11:25:41");
INSERT INTO packing_slip_products VALUES("2","2","18","","2024-08-11 11:37:38","2024-08-11 11:37:38");



CREATE TABLE `packing_slips` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sale_id` int NOT NULL,
  `delivery_id` int DEFAULT NULL,
  `amount` double NOT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO packing_slips VALUES("1","1001","42","1","577","Delivered","2024-08-11 11:25:41","2024-08-11 11:28:06");
INSERT INTO packing_slips VALUES("2","1002","43","2","599","In Transit","2024-08-11 11:37:38","2024-08-11 11:39:22");



CREATE TABLE `password_resets` (
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO password_resets VALUES("ashfaqdev.php@gmail.com","$2y$10$plxHOMxChJlHd9t6FQkoN.4dXMdtZ9fE5tXBBItzjxB1R5JF9OpbO","2023-07-15 17:31:30");



CREATE TABLE `payment_with_cheque` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `payment_id` int NOT NULL,
  `cheque_no` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO payment_with_cheque VALUES("1","21","34242423","2024-06-03 12:29:06","2024-06-03 12:29:06");
INSERT INTO payment_with_cheque VALUES("2","73","999999999","2024-12-04 18:08:52","2024-12-04 18:08:52");



CREATE TABLE `payment_with_credit_card` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `payment_id` int NOT NULL,
  `customer_id` int DEFAULT NULL,
  `customer_stripe_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `charge_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO payment_with_credit_card VALUES("1","62","2","","12345","{"card_number":"123456789323","card_holder_name":"Zuhair","card_type":"Visa"}","2024-12-04 16:41:29","2024-12-04 16:41:29");
INSERT INTO payment_with_credit_card VALUES("2","98","2","","12345","{"card_number":"123456789","card_holder_name":"Zuhair","card_type":"Visa"}","2024-12-30 12:28:22","2024-12-30 12:28:22");
INSERT INTO payment_with_credit_card VALUES("3","99","2","","12345","{"card_number":"123456789","card_holder_name":"Zuhair","card_type":"Visa"}","2024-12-30 12:29:46","2024-12-30 12:29:46");



CREATE TABLE `payment_with_gift_card` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `payment_id` int NOT NULL,
  `gift_card_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `payment_with_paypal` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `payment_id` int NOT NULL,
  `transaction_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `payments` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `payment_reference` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int NOT NULL,
  `purchase_id` int DEFAULT NULL,
  `sale_id` int DEFAULT NULL,
  `cash_register_id` int DEFAULT NULL,
  `account_id` int NOT NULL,
  `payment_receiver` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` double NOT NULL,
  `used_points` double DEFAULT NULL,
  `change` double DEFAULT NULL,
  `paying_method` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO payments VALUES("1","spr-20240119-084017","1","","1","","1","","1758","","","Cash","","2024-01-19 20:40:17","2024-01-19 20:40:17");
INSERT INTO payments VALUES("2","spr-20240119-084441","1","","2","","1","","3017","","","Cash","","2024-01-19 20:44:41","2024-01-19 20:44:41");
INSERT INTO payments VALUES("3","spr-20240210-122224","1","","5","2","1","","1259","","","Cash","","2024-02-10 12:22:24","2024-02-10 12:22:24");
INSERT INTO payments VALUES("4","spr-20240225-014951","1","","6","2","1","","1299.99","","","Credit Card","","2024-02-25 13:49:51","2024-02-25 13:49:51");
INSERT INTO payments VALUES("5","spr-20240225-015013","1","","7","2","1","","2599.98","","","Cash","","2024-02-25 13:50:13","2024-02-25 13:50:13");
INSERT INTO payments VALUES("6","spr-20240228-112744","1","","8","2","1","","2558.99","","","Cash","","2024-02-28 11:27:44","2024-02-28 11:27:44");
INSERT INTO payments VALUES("7","spr-20240421-110143","1","","9","2","1","","350","","","Cash","","2024-04-21 11:01:43","2024-04-21 11:01:43");
INSERT INTO payments VALUES("8","spr-20240428-121544","1","","13","2","1","","1409","","","Cash","","2024-04-28 12:15:44","2024-04-28 12:15:44");
INSERT INTO payments VALUES("9","spr-20240429-062956","1","","14","2","1","","3800.99","","","Cash","","2024-04-29 18:29:56","2024-04-29 18:29:56");
INSERT INTO payments VALUES("12","spr-20240505-052905","1","","20","2","1","","2549.99","","","Cash","","2024-05-05 17:29:05","2024-05-05 17:29:05");
INSERT INTO payments VALUES("13","spr-20240508-020851","1","","22","2","1","","1349.99","","","Cash","","2024-05-08 14:08:51","2024-05-08 14:08:51");
INSERT INTO payments VALUES("14","spr-20240519-022423","1","","23","2","1","","1299.99","","","Cash","","2024-05-19 14:24:23","2024-05-19 14:24:23");
INSERT INTO payments VALUES("15","spr-20240519-022530","1","","24","2","1","","1300","","","Cash","","2024-05-19 14:25:30","2024-05-19 14:25:30");
INSERT INTO payments VALUES("16","spr-20240519-023055","1","","25","2","1","","1300","","","Cash","","2024-05-19 14:30:55","2024-05-19 14:30:55");
INSERT INTO payments VALUES("18","spr-20240521-013249","1","","28","2","1","","1050","","","Cash","","2024-05-21 13:32:49","2024-05-21 13:32:49");
INSERT INTO payments VALUES("19","spr-20240603-122701","1","","29","2","1","","1000","","","Cash","","2024-06-03 12:27:01","2024-06-03 12:27:01");
INSERT INTO payments VALUES("20","spr-20240603-122810","1","","29","2","1","","1000","","","Credit Card","","2024-06-03 12:28:10","2024-06-03 12:28:10");
INSERT INTO payments VALUES("21","spr-20240603-122906","1","","29","2","1","","549.99","","","Cheque","","2024-06-03 12:29:06","2024-06-03 12:29:06");
INSERT INTO payments VALUES("22","spr-20240603-053022","1","","30","2","1","","2300","","","Cash","","2024-06-03 17:30:22","2024-06-03 17:30:22");
INSERT INTO payments VALUES("23","spr-20240626-010119","1","","33","2","1","","1299.99","","","Cash","","2024-06-26 13:01:19","2024-06-26 13:01:19");
INSERT INTO payments VALUES("24","spr-20240718-113630","1","","38","2","1","","1299.99","","0","Cash","","2024-07-18 11:36:30","2024-07-18 11:36:30");
INSERT INTO payments VALUES("25","spr-20240718-015913","1","","39","2","1","","250","","0","Cash","","2024-07-18 13:59:13","2024-07-18 13:59:13");
INSERT INTO payments VALUES("26","spr-20240718-020145","1","","40","1","1","","250","","0","Cash","","2024-07-18 14:01:45","2024-07-18 14:01:45");
INSERT INTO payments VALUES("27","spr-20240811-112806","1","","42","2","1","","500","","0","Cash","","2024-08-11 11:28:06","2024-08-11 11:28:06");
INSERT INTO payments VALUES("28","spr-20240811-112806","1","","42","2","1","","77","","0","Cheque","","2024-08-11 11:28:06","2024-08-11 11:28:06");
INSERT INTO payments VALUES("29","spr-20240811-114852","1","","45","2","1","","1600","","0","Cash","","2024-08-11 11:48:52","2024-08-11 11:48:52");
INSERT INTO payments VALUES("30","spr-20240825-062616","1","","46","3","1","","1299.99","","0","","","2024-08-26 05:26:16","2024-08-26 05:26:16");
INSERT INTO payments VALUES("31","spr-20240825-062630","1","","47","3","1","","1050","","0","Cash","","2024-08-26 05:26:30","2024-08-26 05:26:30");
INSERT INTO payments VALUES("34","spr-20240825-062929","1","","50","3","1","","350","","0","","","2024-08-26 05:29:29","2024-08-26 05:29:29");
INSERT INTO payments VALUES("35","ppr-20241202-024402","1","12","","","0","","870","","0","Cash","","2024-12-02 14:44:02","2024-12-02 14:44:02");
INSERT INTO payments VALUES("36","ppr-20241202-024402","1","13","","","0","","4089","","0","Cash","","2024-12-02 14:44:02","2024-12-02 14:44:02");
INSERT INTO payments VALUES("37","spr-20241203-010211","1","","73","3","1","","1050","","950","Cash","","2024-12-03 13:02:11","2024-12-03 13:02:11");
INSERT INTO payments VALUES("38","spr-20241203-021244","1","","76","3","1","","550","","0","Cash","","2024-12-03 14:12:44","2024-12-03 14:12:44");
INSERT INTO payments VALUES("39","spr-20241203-021927","1","","77","3","1","","500","","0","Cash","","2024-12-03 14:19:27","2024-12-03 14:19:27");
INSERT INTO payments VALUES("40","spr-20241203-021951","1","","78","3","1","","550","","0","Cash","","2024-12-03 14:19:51","2024-12-03 14:19:51");
INSERT INTO payments VALUES("41","spr-20241203-022009","1","","79","3","1","","550","","0","Cash","","2024-12-03 14:20:09","2024-12-03 14:20:09");
INSERT INTO payments VALUES("42","spr-20241203-022958","1","","80","3","1","","1050","","-550","Cash","","2024-12-03 14:29:58","2024-12-03 14:29:58");
INSERT INTO payments VALUES("43","spr-20241203-023529","1","","81","3","1","","1050","","-500","Cash","","2024-12-03 14:35:29","2024-12-03 14:35:29");
INSERT INTO payments VALUES("44","spr-20241203-023727","1","","82","3","1","","1050","","-1050","Cash","","2024-12-03 14:37:27","2024-12-03 14:37:27");
INSERT INTO payments VALUES("45","spr-20241203-024509","1","","84","3","1","","500","","0","Cash","","2024-12-03 14:45:09","2024-12-03 14:45:09");
INSERT INTO payments VALUES("46","spr-20241203-033707","1","","85","3","1","","1050","","950","Cash","","2024-12-03 15:37:07","2024-12-03 15:37:07");
INSERT INTO payments VALUES("47","spr-20241203-033802","1","","86","3","1","","1050","","0","Cash","","2024-12-03 15:38:02","2024-12-03 15:38:02");
INSERT INTO payments VALUES("48","spr-20241203-034048","1","","87","3","1","","1050","","-500","Cash","","2024-12-03 15:40:48","2024-12-03 15:40:48");
INSERT INTO payments VALUES("49","spr-20241203-061213","1","","88","3","1","","100","","0","Cash","","2024-12-03 18:12:13","2024-12-03 18:12:13");
INSERT INTO payments VALUES("50","spr-20241203-061342","1","","89","3","1","","1050","","950","Cash","","2024-12-03 18:13:42","2024-12-03 18:13:42");
INSERT INTO payments VALUES("51","spr-20241203-061505","1","","90","3","1","","1050","","0","Cash","","2024-12-03 18:15:05","2024-12-03 18:15:05");
INSERT INTO payments VALUES("52","spr-20241203-061614","1","","83","3","1","","0","","1050","Cash","","2024-12-03 18:16:14","2024-12-03 18:16:14");
INSERT INTO payments VALUES("53","spr-20241203-061907","1","","91","3","1","","200","","0","Cash","","2024-12-03 18:19:07","2024-12-03 18:19:07");
INSERT INTO payments VALUES("54","spr-20241203-061907","1","","91","3","1","","850","","-650","Cash","","2024-12-03 18:19:07","2024-12-03 18:19:07");
INSERT INTO payments VALUES("55","spr-20241203-061957","1","","92","3","1","","200","","0","Cash","","2024-12-03 18:19:57","2024-12-03 18:19:57");
INSERT INTO payments VALUES("56","spr-20241203-061957","1","","92","3","1","","850","","-650","Cash","","2024-12-03 18:19:57","2024-12-03 18:19:57");
INSERT INTO payments VALUES("57","spr-20241204-043022","1","","93","3","1","","550","","0","Cash","","2024-12-04 16:30:22","2024-12-04 16:30:22");
INSERT INTO payments VALUES("58","spr-20241204-043022","1","","93","3","1","","500","","50","Cash","","2024-12-04 16:30:22","2024-12-04 16:30:22");
INSERT INTO payments VALUES("59","spr-20241204-043903","1","","94","3","1","","500","","0","Cash","","2024-12-04 16:39:03","2024-12-04 16:39:03");
INSERT INTO payments VALUES("60","spr-20241204-043903","1","","94","3","1","","550","","-50","Cash","","2024-12-04 16:39:03","2024-12-04 16:39:03");
INSERT INTO payments VALUES("61","spr-20241204-044129","1","","95","3","1","","550","","0","Cash","","2024-12-04 16:41:29","2024-12-04 16:41:29");
INSERT INTO payments VALUES("62","spr-20241204-044129","1","","95","3","1","","500","","50","Credit Card","","2024-12-04 16:41:29","2024-12-04 16:41:29");
INSERT INTO payments VALUES("63","spr-20241204-044157","1","","96","3","1","","1050","","0","Cash","","2024-12-04 16:41:57","2024-12-04 16:41:57");
INSERT INTO payments VALUES("64","spr-20241204-045422","1","","97","3","1","","1050","","0","Cash","","2024-12-04 16:54:22","2024-12-04 16:54:22");
INSERT INTO payments VALUES("65","spr-20241204-045638","1","","98","3","1","","1050","","0","Cash","","2024-12-04 16:56:38","2024-12-04 16:56:38");
INSERT INTO payments VALUES("66","spr-20241204-055915","1","","102","3","1","","500","","0","Cash","","2024-12-04 17:59:15","2024-12-04 17:59:15");
INSERT INTO payments VALUES("67","spr-20241204-055915","1","","102","3","1","","550","","-50","Cash","","2024-12-04 17:59:15","2024-12-04 17:59:15");
INSERT INTO payments VALUES("68","spr-20241204-060435","1","","103","3","1","","500","","0","Cash","","2024-12-04 18:04:35","2024-12-04 18:04:35");
INSERT INTO payments VALUES("69","spr-20241204-060435","1","","103","3","1","","550","","0","Cash","","2024-12-04 18:04:35","2024-12-04 18:04:35");
INSERT INTO payments VALUES("70","spr-20241204-060520","1","","104","3","1","","1050","","0","Cash","","2024-12-04 18:05:20","2024-12-04 18:05:20");
INSERT INTO payments VALUES("71","spr-20241204-060543","1","","105","3","1","","1050","","150","Cash","","2024-12-04 18:05:43","2024-12-04 18:05:43");
INSERT INTO payments VALUES("72","spr-20241204-060607","1","","106","3","1","","500","","0","Cash","","2024-12-04 18:06:07","2024-12-04 18:06:07");
INSERT INTO payments VALUES("73","spr-20241204-060852","1","","107","3","1","","1050","","0","Cheque","","2024-12-04 18:08:52","2024-12-04 18:08:52");
INSERT INTO payments VALUES("74","spr-20241206-120020","1","","108","3","1","","577","","0","9","","2024-12-06 12:00:20","2024-12-06 12:00:20");
INSERT INTO payments VALUES("75","spr-20241206-121740","1","","109","3","1","","577","","0","Moneipoint","","2024-12-06 12:17:40","2024-12-06 12:17:40");
INSERT INTO payments VALUES("76","spr-20241207-124003","1","","110","3","1","","577","","0","Moneipoint","","2024-12-07 12:40:03","2024-12-07 12:40:03");
INSERT INTO payments VALUES("77","spr-20241208-112955","1","","111","3","1","","577","","0","Moneipoint","","2024-12-08 11:29:55","2024-12-08 11:29:55");
INSERT INTO payments VALUES("78","spr-20241217-102051","1","","106","3","1","","550","","0","Cash","","2024-12-17 10:20:51","2024-12-17 10:20:51");
INSERT INTO payments VALUES("79","spr-20241217-102523","1","","112","3","1","","1199.99","","0","Cash","","2024-12-17 10:25:23","2024-12-17 10:25:23");
INSERT INTO payments VALUES("80","spr-20241217-102708","1","","113","3","1","","1.29","","0","Cash","","2024-12-17 10:27:08","2024-12-17 10:27:08");
INSERT INTO payments VALUES("81","spr-20241218-111745","1","","114","3","1","","945","","0","Cash","","2024-12-18 11:17:45","2024-12-18 11:17:45");
INSERT INTO payments VALUES("82","ppr-20241219-112810","1","14","","","1","","1350","","0","Cash","","2024-12-19 11:28:10","2024-12-19 11:28:10");
INSERT INTO payments VALUES("83","spr-20241219-114402","1","","116","3","1","","27","","0","Cash","","2024-12-19 11:44:02","2024-12-19 11:44:02");
INSERT INTO payments VALUES("84","spr-20241223-121043","9","","118","4","1","","1169.99","","0","Cash","","2024-12-23 12:10:43","2024-12-23 12:10:43");
INSERT INTO payments VALUES("85","spr-20241229-122648","1","","119","3","1","","577","","0","Pesapal","","2024-12-29 00:26:48","2024-12-29 00:26:48");
INSERT INTO payments VALUES("86","spr-20241229-123947","1","","121","3","1","","1169.99","","0","Cash","","2024-12-29 12:39:47","2024-12-29 12:39:47");
INSERT INTO payments VALUES("87","spr-20241229-124414","1","","123","3","1","","1169.99","","0","Moneipoint","","2024-12-29 12:44:14","2024-12-29 12:44:14");
INSERT INTO payments VALUES("88","spr-20241229-124536","1","","124","3","1","","1169.99","","0","Moneipoint","","2024-12-29 12:45:36","2024-12-29 12:45:36");
INSERT INTO payments VALUES("89","spr-20241229-010600","1","","125","3","1","","1169.99","","0","Moneipoint","","2024-12-29 13:06:00","2024-12-29 13:06:00");
INSERT INTO payments VALUES("90","spr-20241229-010827","1","","126","3","1","","1169.99","","0","Moneipoint","","2024-12-29 13:08:27","2024-12-29 13:08:27");
INSERT INTO payments VALUES("91","spr-20241229-010944","1","","127","3","1","","1169.99","","0","Moneipoint","","2024-12-29 13:09:44","2024-12-29 13:09:44");
INSERT INTO payments VALUES("92","spr-20241229-011046","1","","128","3","1","","1169.99","","0","Moneipoint","","2024-12-29 13:10:46","2024-12-29 13:10:46");
INSERT INTO payments VALUES("93","spr-20241229-020304","1","","129","3","1","","1169.99","","0","Moneipoint","","2024-12-29 14:03:04","2024-12-29 14:03:04");
INSERT INTO payments VALUES("94","spr-20241229-024244","1","","130","3","1","","1169.99","","0","Cash","","2024-12-29 14:42:44","2024-12-29 14:42:44");
INSERT INTO payments VALUES("95","spr-20241229-035114","1","","131","3","1","","1169.99","","0","Moneipoint","","2024-12-29 15:51:14","2024-12-29 15:51:14");
INSERT INTO payments VALUES("96","spr-20241229-054802","1","","132","3","1","","1169.99","","0","Moneipoint","","2024-12-29 17:48:02","2024-12-29 17:48:02");
INSERT INTO payments VALUES("97","spr-20241229-055021","1","","133","3","1","","1169.99","","0","Moneipoint","","2024-12-29 17:50:21","2024-12-29 17:50:21");
INSERT INTO payments VALUES("98","spr-20241230-122822","1","","134","3","1","","1169.99","","0","Credit Card","","2024-12-30 12:28:22","2024-12-30 12:28:22");
INSERT INTO payments VALUES("99","spr-20241230-122946","1","","135","3","1","","500","","669.99","Credit Card","","2024-12-30 12:29:46","2024-12-30 12:29:46");
INSERT INTO payments VALUES("100","spr-20241230-122946","1","","135","3","1","","669.99","","-669.99","Cash","","2024-12-30 12:29:46","2024-12-30 12:29:46");
INSERT INTO payments VALUES("101","spr-20241230-123058","1","","136","3","1","","1169.99","","0","Cash","","2024-12-30 12:30:58","2024-12-30 12:30:58");
INSERT INTO payments VALUES("102","spr-20241230-123131","1","","137","3","1","","1169.99","","0","Cash","","2024-12-30 12:31:31","2024-12-30 12:31:31");
INSERT INTO payments VALUES("103","spr-20250101-125049","1","","138","3","1","","1299.99","","0","Moneipoint","","2025-01-01 12:50:49","2025-01-01 12:50:49");
INSERT INTO payments VALUES("104","spr-20250101-023752","1","","139","3","1","","1299.99","","0","Moneipoint","","2025-01-01 14:37:52","2025-01-01 14:37:52");
INSERT INTO payments VALUES("105","ppr-20250108-024142","1","18","","","0","","100","","0","Cash","","2025-01-08 14:41:42","2025-01-08 14:41:42");
INSERT INTO payments VALUES("106","spr-20250109-124048","1","","140","3","1","","100","","0","Cash","","2025-01-09 12:40:48","2025-01-09 12:40:48");
INSERT INTO payments VALUES("107","spr-20250112-121632","1","","141","3","1","","577","","0","Cash","","2025-01-12 12:16:32","2025-01-12 12:16:32");
INSERT INTO payments VALUES("108","spr-20250112-121904","1","","142","3","1","","1.29","","0","Cash","","2025-01-12 12:19:04","2025-01-12 12:19:04");
INSERT INTO payments VALUES("109","spr-20250112-121956","1","","143","3","1","","577","","0","Cash","","2025-01-12 12:19:56","2025-01-12 12:19:56");
INSERT INTO payments VALUES("110","spr-20250112-122210","1","","144","3","1","","100","","0","Cash","","2025-01-12 12:22:10","2025-01-12 12:22:10");
INSERT INTO payments VALUES("111","spr-20250112-122339","1","","145","3","1","","100","","0","Cash","","2025-01-12 12:23:39","2025-01-12 12:23:39");
INSERT INTO payments VALUES("112","spr-20250112-122538","9","","146","4","1","","100","","0","Cash","","2025-01-12 12:25:38","2025-01-12 12:25:38");
INSERT INTO payments VALUES("113","spr-20250112-010845","1","","147","3","1","","100","","0","Cash","","2025-01-12 13:08:45","2025-01-12 13:08:45");
INSERT INTO payments VALUES("114","ppr-20250112-011924","1","40","","","0","","100","","0","Cash","","2025-01-12 13:19:24","2025-01-12 13:19:24");
INSERT INTO payments VALUES("115","ppr-20250112-011924","1","41","","","0","","100","","0","Cash","","2025-01-12 13:19:24","2025-01-12 13:19:24");
INSERT INTO payments VALUES("116","spr-20250112-014034","1","","148","3","1","","200","","0","Cash","","2025-01-12 13:40:34","2025-01-12 13:40:34");
INSERT INTO payments VALUES("119","spr-20250113-035657","1","","160","3","1","","300","","0","Cash","","2025-01-13 15:56:57","2025-01-13 15:56:57");
INSERT INTO payments VALUES("120","spr-20250113-035944","1","","161","3","1","","300","","0","Cash","","2025-01-13 15:59:44","2025-01-13 15:59:44");
INSERT INTO payments VALUES("121","spr-20250113-040000","1","","162","3","1","","300","","0","Cash","","2025-01-13 16:00:00","2025-01-13 16:00:00");
INSERT INTO payments VALUES("122","spr-20250114-020657","1","","163","3","1","","200","","0","Cash","","2025-01-14 14:06:57","2025-01-14 14:06:57");
INSERT INTO payments VALUES("125","spr-20250115-100132","1","","166","3","1","","100","","0","Cash","","2025-01-15 10:01:32","2025-01-15 10:01:32");
INSERT INTO payments VALUES("127","spr-20250115-124611","1","","168","3","1","","100","","0","Cash","","2025-01-15 12:46:11","2025-01-15 12:46:11");
INSERT INTO payments VALUES("130","spr-20250115-035841","1","","172","3","1","","20","","0","Cash","","2025-01-15 15:58:41","2025-01-15 15:58:41");
INSERT INTO payments VALUES("131","spr-20250119-051138","1","","173","3","1","100.00","100","","0","Cash","","2025-01-19 17:11:38","2025-01-19 17:11:38");
INSERT INTO payments VALUES("132","spr-20250119-051831","1","","174","3","1","100.00","100","","0","Cash","","2025-01-19 17:18:31","2025-01-19 17:18:31");
INSERT INTO payments VALUES("139","spr-20250121-104500","1","","190","3","1","","100","","0","Cash","","2025-01-21 10:45:00","2025-01-21 10:45:00");
INSERT INTO payments VALUES("140","spr-20250121-021717","1","","191","3","1","","310","","0","Cash","","2025-01-21 14:17:17","2025-01-21 14:17:17");
INSERT INTO payments VALUES("143","spr-20250126-113536","1","","194","3","1","","100","","0","Cash","","2025-01-26 23:35:36","2025-01-26 23:35:36");



CREATE TABLE `payrolls` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `employee_id` int NOT NULL,
  `account_id` int NOT NULL,
  `user_id` int NOT NULL,
  `amount` double NOT NULL,
  `paying_method` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `permissions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO permissions VALUES("4","products-edit","web","2018-06-03 07:00:09","2018-06-03 07:00:09");
INSERT INTO permissions VALUES("5","products-delete","web","2018-06-04 04:54:22","2018-06-04 04:54:22");
INSERT INTO permissions VALUES("6","products-add","web","2018-06-04 06:34:14","2018-06-04 06:34:14");
INSERT INTO permissions VALUES("7","products-index","web","2018-06-04 09:34:27","2018-06-04 09:34:27");
INSERT INTO permissions VALUES("8","purchases-index","web","2018-06-04 14:03:19","2018-06-04 14:03:19");
INSERT INTO permissions VALUES("9","purchases-add","web","2018-06-04 14:12:25","2018-06-04 14:12:25");
INSERT INTO permissions VALUES("10","purchases-edit","web","2018-06-04 15:47:36","2018-06-04 15:47:36");
INSERT INTO permissions VALUES("11","purchases-delete","web","2018-06-04 15:47:36","2018-06-04 15:47:36");
INSERT INTO permissions VALUES("12","sales-index","web","2018-06-04 16:49:08","2018-06-04 16:49:08");
INSERT INTO permissions VALUES("13","sales-add","web","2018-06-04 16:49:52","2018-06-04 16:49:52");
INSERT INTO permissions VALUES("14","sales-edit","web","2018-06-04 16:49:52","2018-06-04 16:49:52");
INSERT INTO permissions VALUES("15","sales-delete","web","2018-06-04 16:49:53","2018-06-04 16:49:53");
INSERT INTO permissions VALUES("16","quotes-index","web","2018-06-05 04:05:10","2018-06-05 04:05:10");
INSERT INTO permissions VALUES("17","quotes-add","web","2018-06-05 04:05:10","2018-06-05 04:05:10");
INSERT INTO permissions VALUES("18","quotes-edit","web","2018-06-05 04:05:10","2018-06-05 04:05:10");
INSERT INTO permissions VALUES("19","quotes-delete","web","2018-06-05 04:05:10","2018-06-05 04:05:10");
INSERT INTO permissions VALUES("20","transfers-index","web","2018-06-05 04:30:03","2018-06-05 04:30:03");
INSERT INTO permissions VALUES("21","transfers-add","web","2018-06-05 04:30:03","2018-06-05 04:30:03");
INSERT INTO permissions VALUES("22","transfers-edit","web","2018-06-05 04:30:03","2018-06-05 04:30:03");
INSERT INTO permissions VALUES("23","transfers-delete","web","2018-06-05 04:30:03","2018-06-05 04:30:03");
INSERT INTO permissions VALUES("24","returns-index","web","2018-06-05 04:50:24","2018-06-05 04:50:24");
INSERT INTO permissions VALUES("25","returns-add","web","2018-06-05 04:50:24","2018-06-05 04:50:24");
INSERT INTO permissions VALUES("26","returns-edit","web","2018-06-05 04:50:25","2018-06-05 04:50:25");
INSERT INTO permissions VALUES("27","returns-delete","web","2018-06-05 04:50:25","2018-06-05 04:50:25");
INSERT INTO permissions VALUES("28","customers-index","web","2018-06-05 05:15:54","2018-06-05 05:15:54");
INSERT INTO permissions VALUES("29","customers-add","web","2018-06-05 05:15:55","2018-06-05 05:15:55");
INSERT INTO permissions VALUES("30","customers-edit","web","2018-06-05 05:15:55","2018-06-05 05:15:55");
INSERT INTO permissions VALUES("31","customers-delete","web","2018-06-05 05:15:55","2018-06-05 05:15:55");
INSERT INTO permissions VALUES("32","suppliers-index","web","2018-06-05 05:40:12","2018-06-05 05:40:12");
INSERT INTO permissions VALUES("33","suppliers-add","web","2018-06-05 05:40:12","2018-06-05 05:40:12");
INSERT INTO permissions VALUES("34","suppliers-edit","web","2018-06-05 05:40:12","2018-06-05 05:40:12");
INSERT INTO permissions VALUES("35","suppliers-delete","web","2018-06-05 05:40:12","2018-06-05 05:40:12");
INSERT INTO permissions VALUES("36","product-report","web","2018-06-25 05:05:33","2018-06-25 05:05:33");
INSERT INTO permissions VALUES("37","purchase-report","web","2018-06-25 05:24:56","2018-06-25 05:24:56");
INSERT INTO permissions VALUES("38","sale-report","web","2018-06-25 05:33:13","2018-06-25 05:33:13");
INSERT INTO permissions VALUES("39","customer-report","web","2018-06-25 05:36:51","2018-06-25 05:36:51");
INSERT INTO permissions VALUES("40","due-report","web","2018-06-25 05:39:52","2018-06-25 05:39:52");
INSERT INTO permissions VALUES("41","users-index","web","2018-06-25 06:00:10","2018-06-25 06:00:10");
INSERT INTO permissions VALUES("42","users-add","web","2018-06-25 06:00:10","2018-06-25 06:00:10");
INSERT INTO permissions VALUES("43","users-edit","web","2018-06-25 06:01:30","2018-06-25 06:01:30");
INSERT INTO permissions VALUES("44","users-delete","web","2018-06-25 06:01:30","2018-06-25 06:01:30");
INSERT INTO permissions VALUES("45","profit-loss","web","2018-07-15 03:50:05","2018-07-15 03:50:05");
INSERT INTO permissions VALUES("46","best-seller","web","2018-07-15 04:01:38","2018-07-15 04:01:38");
INSERT INTO permissions VALUES("47","daily-sale","web","2018-07-15 04:24:21","2018-07-15 04:24:21");
INSERT INTO permissions VALUES("48","monthly-sale","web","2018-07-15 04:30:41","2018-07-15 04:30:41");
INSERT INTO permissions VALUES("49","daily-purchase","web","2018-07-15 04:36:46","2018-07-15 04:36:46");
INSERT INTO permissions VALUES("50","monthly-purchase","web","2018-07-15 04:48:17","2018-07-15 04:48:17");
INSERT INTO permissions VALUES("51","payment-report","web","2018-07-15 05:10:41","2018-07-15 05:10:41");
INSERT INTO permissions VALUES("52","warehouse-stock-report","web","2018-07-15 05:16:55","2018-07-15 05:16:55");
INSERT INTO permissions VALUES("53","product-qty-alert","web","2018-07-15 05:33:21","2018-07-15 05:33:21");
INSERT INTO permissions VALUES("54","supplier-report","web","2018-07-30 09:00:01","2018-07-30 09:00:01");
INSERT INTO permissions VALUES("55","expenses-index","web","2018-09-05 07:07:10","2018-09-05 07:07:10");
INSERT INTO permissions VALUES("56","expenses-add","web","2018-09-05 07:07:10","2018-09-05 07:07:10");
INSERT INTO permissions VALUES("57","expenses-edit","web","2018-09-05 07:07:10","2018-09-05 07:07:10");
INSERT INTO permissions VALUES("58","expenses-delete","web","2018-09-05 07:07:11","2018-09-05 07:07:11");
INSERT INTO permissions VALUES("59","general_setting","web","2018-10-20 05:10:04","2018-10-20 05:10:04");
INSERT INTO permissions VALUES("60","mail_setting","web","2018-10-20 05:10:04","2018-10-20 05:10:04");
INSERT INTO permissions VALUES("61","pos_setting","web","2018-10-20 05:10:04","2018-10-20 05:10:04");
INSERT INTO permissions VALUES("62","hrm_setting","web","2019-01-02 16:30:23","2019-01-02 16:30:23");
INSERT INTO permissions VALUES("63","purchase-return-index","web","2019-01-03 03:45:14","2019-01-03 03:45:14");
INSERT INTO permissions VALUES("64","purchase-return-add","web","2019-01-03 03:45:14","2019-01-03 03:45:14");
INSERT INTO permissions VALUES("65","purchase-return-edit","web","2019-01-03 03:45:14","2019-01-03 03:45:14");
INSERT INTO permissions VALUES("66","purchase-return-delete","web","2019-01-03 03:45:14","2019-01-03 03:45:14");
INSERT INTO permissions VALUES("67","account-index","web","2019-01-03 04:06:13","2019-01-03 04:06:13");
INSERT INTO permissions VALUES("68","balance-sheet","web","2019-01-03 04:06:14","2019-01-03 04:06:14");
INSERT INTO permissions VALUES("69","account-statement","web","2019-01-03 04:06:14","2019-01-03 04:06:14");
INSERT INTO permissions VALUES("70","department","web","2019-01-03 04:30:01","2019-01-03 04:30:01");
INSERT INTO permissions VALUES("71","attendance","web","2019-01-03 04:30:01","2019-01-03 04:30:01");
INSERT INTO permissions VALUES("72","payroll","web","2019-01-03 04:30:01","2019-01-03 04:30:01");
INSERT INTO permissions VALUES("73","employees-index","web","2019-01-03 04:52:19","2019-01-03 04:52:19");
INSERT INTO permissions VALUES("74","employees-add","web","2019-01-03 04:52:19","2019-01-03 04:52:19");
INSERT INTO permissions VALUES("75","employees-edit","web","2019-01-03 04:52:19","2019-01-03 04:52:19");
INSERT INTO permissions VALUES("76","employees-delete","web","2019-01-03 04:52:19","2019-01-03 04:52:19");
INSERT INTO permissions VALUES("77","user-report","web","2019-01-16 12:48:18","2019-01-16 12:48:18");
INSERT INTO permissions VALUES("78","stock_count","web","2019-02-17 16:32:01","2019-02-17 16:32:01");
INSERT INTO permissions VALUES("79","adjustment","web","2019-02-17 16:32:02","2019-02-17 16:32:02");
INSERT INTO permissions VALUES("80","sms_setting","web","2019-02-22 11:18:03","2019-02-22 11:18:03");
INSERT INTO permissions VALUES("81","create_sms","web","2019-02-22 11:18:03","2019-02-22 11:18:03");
INSERT INTO permissions VALUES("82","print_barcode","web","2019-03-07 11:02:19","2019-03-07 11:02:19");
INSERT INTO permissions VALUES("83","empty_database","web","2019-03-07 11:02:19","2019-03-07 11:02:19");
INSERT INTO permissions VALUES("84","customer_group","web","2019-03-07 11:37:15","2019-03-07 11:37:15");
INSERT INTO permissions VALUES("85","unit","web","2019-03-07 11:37:15","2019-03-07 11:37:15");
INSERT INTO permissions VALUES("86","tax","web","2019-03-07 11:37:15","2019-03-07 11:37:15");
INSERT INTO permissions VALUES("87","gift_card","web","2019-03-07 12:29:38","2019-03-07 12:29:38");
INSERT INTO permissions VALUES("88","coupon","web","2019-03-07 12:29:38","2019-03-07 12:29:38");
INSERT INTO permissions VALUES("89","holiday","web","2019-10-19 14:57:15","2019-10-19 14:57:15");
INSERT INTO permissions VALUES("90","warehouse-report","web","2019-10-22 12:00:23","2019-10-22 12:00:23");
INSERT INTO permissions VALUES("91","warehouse","web","2020-02-26 12:47:32","2020-02-26 12:47:32");
INSERT INTO permissions VALUES("92","brand","web","2020-02-26 12:59:59","2020-02-26 12:59:59");
INSERT INTO permissions VALUES("93","billers-index","web","2020-02-26 13:11:15","2020-02-26 13:11:15");
INSERT INTO permissions VALUES("94","billers-add","web","2020-02-26 13:11:15","2020-02-26 13:11:15");
INSERT INTO permissions VALUES("95","billers-edit","web","2020-02-26 13:11:15","2020-02-26 13:11:15");
INSERT INTO permissions VALUES("96","billers-delete","web","2020-02-26 13:11:15","2020-02-26 13:11:15");
INSERT INTO permissions VALUES("97","money-transfer","web","2020-03-02 11:41:48","2020-03-02 11:41:48");
INSERT INTO permissions VALUES("98","category","web","2020-07-13 18:13:16","2020-07-13 18:13:16");
INSERT INTO permissions VALUES("99","delivery","web","2020-07-13 18:13:16","2020-07-13 18:13:16");
INSERT INTO permissions VALUES("100","send_notification","web","2020-10-31 12:21:31","2020-10-31 12:21:31");
INSERT INTO permissions VALUES("101","today_sale","web","2020-10-31 12:57:04","2020-10-31 12:57:04");
INSERT INTO permissions VALUES("102","today_profit","web","2020-10-31 12:57:04","2020-10-31 12:57:04");
INSERT INTO permissions VALUES("103","currency","web","2020-11-09 06:23:11","2020-11-09 06:23:11");
INSERT INTO permissions VALUES("104","backup_database","web","2020-11-15 06:16:55","2020-11-15 06:16:55");
INSERT INTO permissions VALUES("105","reward_point_setting","web","2021-06-27 10:34:42","2021-06-27 10:34:42");
INSERT INTO permissions VALUES("106","revenue_profit_summary","web","2022-02-08 19:57:21","2022-02-08 19:57:21");
INSERT INTO permissions VALUES("107","cash_flow","web","2022-02-08 19:57:22","2022-02-08 19:57:22");
INSERT INTO permissions VALUES("108","monthly_summary","web","2022-02-08 19:57:22","2022-02-08 19:57:22");
INSERT INTO permissions VALUES("109","yearly_report","web","2022-02-08 19:57:22","2022-02-08 19:57:22");
INSERT INTO permissions VALUES("110","discount_plan","web","2022-02-16 15:12:26","2022-02-16 15:12:26");
INSERT INTO permissions VALUES("111","discount","web","2022-02-16 15:12:38","2022-02-16 15:12:38");
INSERT INTO permissions VALUES("112","product-expiry-report","web","2022-03-30 11:39:20","2022-03-30 11:39:20");
INSERT INTO permissions VALUES("113","purchase-payment-index","web","2022-06-05 20:12:27","2022-06-05 20:12:27");
INSERT INTO permissions VALUES("114","purchase-payment-add","web","2022-06-05 20:12:28","2022-06-05 20:12:28");
INSERT INTO permissions VALUES("115","purchase-payment-edit","web","2022-06-05 20:12:28","2022-06-05 20:12:28");
INSERT INTO permissions VALUES("116","purchase-payment-delete","web","2022-06-05 20:12:28","2022-06-05 20:12:28");
INSERT INTO permissions VALUES("117","sale-payment-index","web","2022-06-05 20:12:28","2022-06-05 20:12:28");
INSERT INTO permissions VALUES("118","sale-payment-add","web","2022-06-05 20:12:28","2022-06-05 20:12:28");
INSERT INTO permissions VALUES("119","sale-payment-edit","web","2022-06-05 20:12:28","2022-06-05 20:12:28");
INSERT INTO permissions VALUES("120","sale-payment-delete","web","2022-06-05 20:12:28","2022-06-05 20:12:28");
INSERT INTO permissions VALUES("121","all_notification","web","2022-06-05 20:12:29","2022-06-05 20:12:29");
INSERT INTO permissions VALUES("122","sale-report-chart","web","2022-06-05 20:12:29","2022-06-05 20:12:29");
INSERT INTO permissions VALUES("123","dso-report","web","2022-06-05 20:12:29","2022-06-05 20:12:29");
INSERT INTO permissions VALUES("124","product_history","web","2022-08-25 20:04:05","2022-08-25 20:04:05");
INSERT INTO permissions VALUES("125","supplier-due-report","web","2022-08-31 15:46:33","2022-08-31 15:46:33");
INSERT INTO permissions VALUES("126","custom_field","web","2023-05-02 13:41:35","2023-05-02 13:41:35");
INSERT INTO permissions VALUES("127","incomes-index","web","2024-08-11 10:50:59","2024-08-11 10:50:59");
INSERT INTO permissions VALUES("128","incomes-add","web","2024-08-11 10:50:59","2024-08-11 10:50:59");
INSERT INTO permissions VALUES("129","incomes-edit","web","2024-08-11 10:50:59","2024-08-11 10:50:59");
INSERT INTO permissions VALUES("130","incomes-delete","web","2024-08-11 10:50:59","2024-08-11 10:50:59");
INSERT INTO permissions VALUES("131","packing_slip_challan","web","2024-08-11 10:51:00","2024-08-11 10:51:00");
INSERT INTO permissions VALUES("132","biller-report","web","2024-08-26 05:30:44","2024-08-26 05:30:44");



CREATE TABLE `pos_setting` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `warehouse_id` int NOT NULL,
  `biller_id` int NOT NULL,
  `product_number` int NOT NULL,
  `keybord_active` tinyint(1) NOT NULL,
  `is_table` tinyint(1) NOT NULL DEFAULT '0',
  `send_sms` tinyint(1) NOT NULL DEFAULT '0',
  `stripe_public_key` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stripe_secret_key` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paypal_live_api_username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paypal_live_api_password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paypal_live_api_secret` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_options` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `invoice_option` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `thermal_invoice_size` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '80',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  UNIQUE KEY `pos_setting_id_unique` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO pos_setting VALUES("1","2","1","1","3","0","0","1","","","admin","admin","","cash,card,cheque,gift_card,deposit,pesapal,moneipoint,bkash","thermal","80","2018-09-02 09:17:04","2025-01-26 14:14:55");



CREATE TABLE `product_adjustments` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `adjustment_id` int NOT NULL,
  `product_id` int NOT NULL,
  `variant_id` int DEFAULT NULL,
  `unit_cost` double DEFAULT NULL,
  `qty` double NOT NULL,
  `action` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `product_batches` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `batch_no` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expired_date` date NOT NULL,
  `qty` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `product_productions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `production_id` int NOT NULL,
  `product_id` int NOT NULL,
  `qty` double NOT NULL,
  `recieved` double NOT NULL,
  `purchase_unit_id` int NOT NULL,
  `net_unit_cost` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO product_productions VALUES("1","1","39","2","2","1","450","0","0","900","2024-12-19 15:32:43","2024-12-19 15:32:43");



CREATE TABLE `product_purchases` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `purchase_id` int NOT NULL,
  `product_id` int NOT NULL,
  `product_batch_id` int DEFAULT NULL,
  `variant_id` int DEFAULT NULL,
  `imei_number` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `qty` double NOT NULL,
  `recieved` double NOT NULL,
  `return_qty` double NOT NULL DEFAULT '0',
  `purchase_unit_id` int NOT NULL,
  `net_unit_cost` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO product_purchases VALUES("1","1","23","","","","10","10","0","1","439","0","0","0","4390","2024-01-19 19:46:04","2024-01-19 19:46:04");
INSERT INTO product_purchases VALUES("2","1","27","","","","10","10","0","1","0.89","0","0","0","8.9","2024-01-19 19:46:04","2024-01-19 19:46:04");
INSERT INTO product_purchases VALUES("3","1","20","","","","10","10","0","1","399","0","0","0","3990","2024-01-19 19:46:04","2024-01-19 19:46:04");
INSERT INTO product_purchases VALUES("4","1","17","","","","10","10","0","1","349","0","0","0","3490","2024-01-19 19:46:04","2024-01-19 19:46:04");
INSERT INTO product_purchases VALUES("5","1","16","","","","10","10","0","1","79","0","0","0","790","2024-01-19 19:46:04","2024-01-19 19:46:04");
INSERT INTO product_purchases VALUES("6","1","30","","","","10","10","0","1","100","0","10","100","1100","2024-01-19 19:46:04","2024-01-19 19:46:04");
INSERT INTO product_purchases VALUES("7","1","19","","","","10","10","0","1","817.27","0","10","817.27","8990","2024-01-19 19:46:04","2024-01-19 19:46:04");
INSERT INTO product_purchases VALUES("8","1","3","","","","10","10","0","1","272.73","0","10","272.73","3000","2024-01-19 19:46:05","2024-01-19 19:46:05");
INSERT INTO product_purchases VALUES("9","1","7","","","","10","10","0","1","818.17","0","10","818.17","8999.9","2024-01-19 19:46:05","2024-01-19 19:46:05");
INSERT INTO product_purchases VALUES("10","1","2","","","","10","10","0","1","909.09","0","10","909.09","10000","2024-01-19 19:46:05","2024-01-19 19:46:05");
INSERT INTO product_purchases VALUES("11","2","6","","","","10","10","0","1","999.99","0","0","0","9999.9","2024-01-19 19:50:04","2024-01-19 19:50:04");
INSERT INTO product_purchases VALUES("12","2","13","","","","10","10","0","1","227.27","0","10","227.27","2500","2024-01-19 19:50:04","2024-01-19 19:50:04");
INSERT INTO product_purchases VALUES("13","2","10","","","","10","10","0","1","990","0","0","0","9900","2024-01-19 19:50:04","2024-01-19 19:50:04");
INSERT INTO product_purchases VALUES("14","2","21","","","","10","10","0","1","369","0","0","0","3690","2024-01-19 19:50:04","2024-01-19 19:50:04");
INSERT INTO product_purchases VALUES("15","2","8","","","","10","10","0","1","1090","0","10","1090","11990","2024-01-19 19:50:04","2024-01-19 19:50:04");
INSERT INTO product_purchases VALUES("16","2","12","","","","10","10","0","1","908.18","0","10","908.18","9990","2024-01-19 19:50:04","2024-01-19 19:50:04");
INSERT INTO product_purchases VALUES("17","2","29","","","","10","10","0","1","2.39","0","0","0","23.9","2024-01-19 19:50:04","2024-01-19 19:50:04");
INSERT INTO product_purchases VALUES("18","2","26","","","","10","10","0","4","2.99","0","0","0","29.9","2024-01-19 19:50:04","2024-01-19 19:50:04");
INSERT INTO product_purchases VALUES("19","2","9","","","","10","10","0","1","399","0","0","0","3990","2024-01-19 19:50:04","2024-01-19 19:50:04");
INSERT INTO product_purchases VALUES("20","2","11","","","","10","10","0","1","1363.64","0","10","1363.64","15000","2024-01-19 19:50:04","2024-01-19 19:50:04");
INSERT INTO product_purchases VALUES("21","3","1","","","","10","10","0","1","999.99","0","10","999.99","10999.9","2024-01-19 19:53:21","2024-01-19 19:53:21");
INSERT INTO product_purchases VALUES("22","3","18","","","","10","10","0","1","417.27","0","10","417.27","4590","2024-01-19 19:53:21","2024-01-19 19:53:21");
INSERT INTO product_purchases VALUES("23","3","25","","","","10","10","0","1","130","0","0","0","1300","2024-01-19 19:53:21","2024-01-19 19:53:21");
INSERT INTO product_purchases VALUES("24","3","28","","","","10","10","0","1","2.39","0","0","0","23.9","2024-01-19 19:53:21","2024-01-19 19:53:21");
INSERT INTO product_purchases VALUES("25","3","14","","","","10","10","0","1","318.18","0","10","318.18","3500","2024-01-19 19:53:21","2024-01-19 19:53:21");
INSERT INTO product_purchases VALUES("26","3","24","","","","10","10","0","1","271.82","0","10","271.82","2990","2024-01-19 19:53:21","2024-01-19 19:53:21");
INSERT INTO product_purchases VALUES("27","3","4","","","","10","10","0","1","818.18","0","10","818.18","9000","2024-01-19 19:53:21","2024-01-19 19:53:21");
INSERT INTO product_purchases VALUES("28","3","5","","","","10","10","0","1","864.54","0","10","864.54","9509.9","2024-01-19 19:53:21","2024-01-19 19:53:21");
INSERT INTO product_purchases VALUES("29","3","22","","","","10","10","0","1","275","0","0","0","2750","2024-01-19 19:53:21","2024-01-19 19:53:21");
INSERT INTO product_purchases VALUES("30","3","15","","","","10","10","0","1","499","0","0","0","4990","2024-01-19 19:53:21","2024-01-19 19:53:21");
INSERT INTO product_purchases VALUES("31","4","1","","","","11","11","0","1","999.99","0","10","1099.99","12099.89","2024-01-19 20:26:48","2024-01-19 20:26:48");
INSERT INTO product_purchases VALUES("32","4","18","","","","10","10","0","1","417.27","0","10","417.27","4590","2024-01-19 20:26:48","2024-01-19 20:26:48");
INSERT INTO product_purchases VALUES("33","4","25","","","","10","10","0","1","130","0","0","0","1300","2024-01-19 20:26:48","2024-01-19 20:26:48");
INSERT INTO product_purchases VALUES("34","4","28","","","","10","10","0","1","2.39","0","0","0","23.9","2024-01-19 20:26:48","2024-01-19 20:26:48");
INSERT INTO product_purchases VALUES("35","4","14","","","","10","10","0","1","318.18","0","10","318.18","3500","2024-01-19 20:26:49","2024-01-19 20:26:49");
INSERT INTO product_purchases VALUES("36","4","24","","","","10","10","0","1","271.82","0","10","271.82","2990","2024-01-19 20:26:49","2024-01-19 20:26:49");
INSERT INTO product_purchases VALUES("37","4","4","","","","10","10","0","1","818.18","0","10","818.18","9000","2024-01-19 20:26:49","2024-01-19 20:26:49");
INSERT INTO product_purchases VALUES("38","4","5","","","","10","10","0","1","864.54","0","10","864.54","9509.9","2024-01-19 20:26:49","2024-01-19 20:26:49");
INSERT INTO product_purchases VALUES("39","4","22","","","","10","10","0","1","275","0","0","0","2750","2024-01-19 20:26:49","2024-01-19 20:26:49");
INSERT INTO product_purchases VALUES("40","4","15","","","","10","10","0","1","499","0","0","0","4990","2024-01-19 20:26:49","2024-01-19 20:26:49");
INSERT INTO product_purchases VALUES("41","5","23","","","","10","10","0","1","439","0","0","0","4390","2024-01-19 20:28:26","2024-01-19 20:28:26");
INSERT INTO product_purchases VALUES("42","5","27","","","","10","10","0","1","0.89","0","0","0","8.9","2024-01-19 20:28:26","2024-01-19 20:28:26");
INSERT INTO product_purchases VALUES("43","5","20","","","","10","10","0","1","399","0","0","0","3990","2024-01-19 20:28:26","2024-01-19 20:28:26");
INSERT INTO product_purchases VALUES("44","5","17","","","","10","10","0","1","349","0","0","0","3490","2024-01-19 20:28:26","2024-01-19 20:28:26");
INSERT INTO product_purchases VALUES("45","5","16","","","","10","10","0","1","79","0","0","0","790","2024-01-19 20:28:26","2024-01-19 20:28:26");
INSERT INTO product_purchases VALUES("46","5","30","","","","10","10","0","1","100","0","10","100","1100","2024-01-19 20:28:26","2024-01-19 20:28:26");
INSERT INTO product_purchases VALUES("47","5","19","","","","10","10","0","1","817.27","0","10","817.27","8990","2024-01-19 20:28:26","2024-01-19 20:28:26");
INSERT INTO product_purchases VALUES("48","5","3","","","","10","10","0","1","272.73","0","10","272.73","3000","2024-01-19 20:28:26","2024-01-19 20:28:26");
INSERT INTO product_purchases VALUES("49","5","7","","","","10","10","0","1","818.17","0","10","818.17","8999.9","2024-01-19 20:28:26","2024-01-19 20:28:26");
INSERT INTO product_purchases VALUES("50","5","2","","","","10","10","0","1","909.09","0","10","909.09","10000","2024-01-19 20:28:26","2024-01-19 20:28:26");
INSERT INTO product_purchases VALUES("51","6","6","","","","10","10","0","1","999.99","0","0","0","9999.9","2024-01-19 20:28:35","2024-01-19 20:28:35");
INSERT INTO product_purchases VALUES("52","6","13","","","","10","10","0","1","227.27","0","10","227.27","2500","2024-01-19 20:28:35","2024-01-19 20:28:35");
INSERT INTO product_purchases VALUES("53","6","10","","","","10","10","0","1","990","0","0","0","9900","2024-01-19 20:28:35","2024-01-19 20:28:35");
INSERT INTO product_purchases VALUES("54","6","21","","","","10","10","0","1","369","0","0","0","3690","2024-01-19 20:28:35","2024-01-19 20:28:35");
INSERT INTO product_purchases VALUES("55","6","8","","","","10","10","0","1","1090","0","10","1090","11990","2024-01-19 20:28:35","2024-01-19 20:28:35");
INSERT INTO product_purchases VALUES("56","6","12","","","","10","10","0","1","908.18","0","10","908.18","9990","2024-01-19 20:28:35","2024-01-19 20:28:35");
INSERT INTO product_purchases VALUES("57","6","29","","","","10","10","0","1","2.39","0","0","0","23.9","2024-01-19 20:28:35","2024-01-19 20:28:35");
INSERT INTO product_purchases VALUES("58","6","26","","","","10","10","0","4","2.99","0","0","0","29.9","2024-01-19 20:28:35","2024-01-19 20:28:35");
INSERT INTO product_purchases VALUES("59","6","9","","","","10","10","0","1","399","0","0","0","3990","2024-01-19 20:28:35","2024-01-19 20:28:35");
INSERT INTO product_purchases VALUES("60","6","11","","","","10","10","0","1","1363.64","0","10","1363.64","15000","2024-01-19 20:28:35","2024-01-19 20:28:35");
INSERT INTO product_purchases VALUES("61","7","17","","","","1","1","0","1","349","0","0","0","349","2024-01-19 20:52:02","2024-01-19 20:52:02");
INSERT INTO product_purchases VALUES("62","7","20","","","","1","1","0","1","399","0","0","0","399","2024-01-19 20:52:02","2024-01-19 20:52:02");
INSERT INTO product_purchases VALUES("64","8","7","","","","6","6","0","1","800","0","10","480","5280","2024-06-20 11:08:26","2024-06-20 11:08:26");
INSERT INTO product_purchases VALUES("65","9","33","","","1001,1002,1003,1004,1005","5","5","0","1","100","0","0","0","500","2024-07-18 13:41:45","2024-07-18 13:41:45");
INSERT INTO product_purchases VALUES("67","10","33","","","2001,2002,2003,2004,2005","5","5","0","1","100","0","0","0","500","2024-07-18 13:51:35","2024-07-18 13:51:35");
INSERT INTO product_purchases VALUES("68","11","34","","2","","10","10","0","1","100","0","0","0","1000","2024-11-24 15:02:22","2024-11-24 15:02:22");
INSERT INTO product_purchases VALUES("69","12","35","","","","10","10","0","1","72.5","0","20","145","870","2024-12-02 14:44:02","2024-12-02 14:44:02");
INSERT INTO product_purchases VALUES("70","13","35","","","","47","47","0","1","72.5","0","20","681.5","4089","2024-12-02 14:44:02","2024-12-02 14:44:02");
INSERT INTO product_purchases VALUES("71","14","38","","5","","3","3","0","1","150","0","0","0","450","2024-12-19 11:28:01","2024-12-19 11:28:01");
INSERT INTO product_purchases VALUES("72","14","37","","5","","3","3","0","1","150","0","0","0","450","2024-12-19 11:28:01","2024-12-19 11:28:01");
INSERT INTO product_purchases VALUES("73","14","36","","5","","3","3","0","1","150","0","0","0","450","2024-12-19 11:28:01","2024-12-19 11:28:01");
INSERT INTO product_purchases VALUES("74","15","40","","","","10","10","0","1","5","0","0","0","50","2024-12-19 11:40:33","2024-12-19 11:40:33");
INSERT INTO product_purchases VALUES("75","15","41","","","","10","10","0","1","5","0","0","0","50","2024-12-19 11:40:33","2024-12-19 11:40:33");
INSERT INTO product_purchases VALUES("76","16","3","","","","1","1","0","1","272.73","0","10","27.27","300","2025-01-08 12:39:27","2025-01-08 12:39:27");
INSERT INTO product_purchases VALUES("77","17","26","","","","5","5","0","1","10.5","0","0","0","52.5","2025-01-08 12:59:11","2025-01-08 12:59:11");
INSERT INTO product_purchases VALUES("78","17","7","","","","10","10","0","4","1","0","0","0","10","2025-01-08 12:59:11","2025-01-08 12:59:11");
INSERT INTO product_purchases VALUES("79","17","31","","","","5","5","0","1","0.75","0","0","0","3.75","2025-01-08 12:59:11","2025-01-08 12:59:11");
INSERT INTO product_purchases VALUES("80","18","44","","","","10","10","0","1","10","0","0","0","100","2025-01-08 14:41:42","2025-01-08 14:41:42");
INSERT INTO product_purchases VALUES("85","23","48","","10","silver01,silver02","2","2","0","1","10","0","0","0","20","2025-01-08 18:51:26","2025-01-08 18:51:26");
INSERT INTO product_purchases VALUES("100","40","54","","","","10","10","0","1","10","0","0","0","100","2025-01-12 13:19:24","2025-01-12 13:19:24");
INSERT INTO product_purchases VALUES("101","41","54","","","","10","10","0","1","10","0","0","0","100","2025-01-12 13:19:24","2025-01-12 13:19:24");
INSERT INTO product_purchases VALUES("102","42","54","","","aa1,aa2","2","2","0","1","10","0","0","0","20","2025-01-12 13:21:28","2025-01-12 13:21:28");
INSERT INTO product_purchases VALUES("103","43","55","","5","dd1,dd2","2","2","0","1","10","0","0","0","20","2025-01-12 13:22:24","2025-01-12 13:22:24");
INSERT INTO product_purchases VALUES("104","44","55","","11","dd3,dd4","2","2","0","1","10","0","0","0","20","2025-01-12 13:53:23","2025-01-12 13:53:23");
INSERT INTO product_purchases VALUES("105","45","55","","11","dd5","1","1","0","1","10","0","0","0","10","2025-01-12 17:29:00","2025-01-12 17:29:00");
INSERT INTO product_purchases VALUES("107","47","55","","5","dd6,dd7","2","2","0","1","10","0","0","0","20","2025-01-13 14:07:55","2025-01-13 14:07:55");
INSERT INTO product_purchases VALUES("108","48","55","","11","dd8,dd9","2","2","0","1","10","0","0","0","20","2025-01-13 14:08:43","2025-01-13 14:08:43");
INSERT INTO product_purchases VALUES("117","57","55","","5","dd20,dd21","2","2","0","1","10","0","0","0","20","2025-01-16 12:09:32","2025-01-16 12:09:32");
INSERT INTO product_purchases VALUES("118","58","55","","11","aa1,aa2","2","2","0","1","10","0","0","0","20","2025-01-17 00:25:35","2025-01-17 00:25:35");
INSERT INTO product_purchases VALUES("119","59","63","","11","b-456,b-455","2","2","0","1","10","0","0","0","20","2025-01-17 00:30:53","2025-01-17 00:30:53");
INSERT INTO product_purchases VALUES("120","59","63","","10","sl-456,sl-455","2","2","0","1","10","0","0","0","20","2025-01-17 00:30:53","2025-01-17 00:30:53");
INSERT INTO product_purchases VALUES("121","60","64","","","bb1,bb2","2","2","0","1","10","0","0","0","20","2025-01-19 17:18:10","2025-01-19 17:18:10");
INSERT INTO product_purchases VALUES("124","63","80","","10","qq1,qq2","4","4","0","1","10","0","0","0","40","2025-01-21 14:15:41","2025-01-21 14:15:41");
INSERT INTO product_purchases VALUES("125","64","80","","5","qq3,qq4","2","2","0","1","10","0","0","0","20","2025-01-21 14:16:18","2025-01-21 14:16:18");



CREATE TABLE `product_quotation` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `quotation_id` int NOT NULL,
  `product_id` int NOT NULL,
  `product_batch_id` int DEFAULT NULL,
  `variant_id` int DEFAULT NULL,
  `qty` double NOT NULL,
  `sale_unit_id` int NOT NULL,
  `net_unit_price` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO product_quotation VALUES("1","1","17","","","1","1","499","0","0","0","499","2024-01-19 20:51:32","2024-01-19 20:51:32");
INSERT INTO product_quotation VALUES("2","1","20","","","1","1","499","0","0","0","499","2024-01-19 20:51:32","2024-01-19 20:51:32");
INSERT INTO product_quotation VALUES("3","2","20","","","3","1","499","0","0","0","1497","2024-08-26 05:01:17","2024-08-26 05:01:17");
INSERT INTO product_quotation VALUES("4","3","23","","","1","1","577","0","0","0","577","2024-11-27 15:09:38","2024-11-27 15:09:38");



CREATE TABLE `product_returns` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `return_id` int NOT NULL,
  `product_id` int NOT NULL,
  `product_batch_id` int DEFAULT NULL,
  `variant_id` int DEFAULT NULL,
  `imei_number` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `qty` double NOT NULL,
  `sale_unit_id` int NOT NULL,
  `net_unit_price` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO product_returns VALUES("1","1","1","","","","1","1","1181.81","0","10","118.18","1299.99","2024-03-24 13:08:23","2024-03-24 13:08:23");
INSERT INTO product_returns VALUES("2","2","5","","","","1","1","1046.35","0","10","104.64","1150.99","2024-04-29 18:30:38","2024-04-29 18:30:38");
INSERT INTO product_returns VALUES("3","2","3","","","","1","1","318.18","0","10","31.82","350","2024-04-29 18:30:38","2024-04-29 18:30:38");
INSERT INTO product_returns VALUES("4","3","1","","","","1","1","1181.81","0","10","118.18","1299.99","2024-06-26 13:01:42","2024-06-26 13:01:42");



CREATE TABLE `product_sales` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `sale_id` int NOT NULL,
  `product_id` int NOT NULL,
  `product_batch_id` int DEFAULT NULL,
  `variant_id` int DEFAULT NULL,
  `imei_number` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `qty` double NOT NULL,
  `return_qty` double NOT NULL DEFAULT '0',
  `sale_unit_id` int NOT NULL,
  `net_unit_price` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_delivered` tinyint(1) DEFAULT NULL,
  `is_packing` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=227 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO product_sales VALUES("1","1","14","","","","1","0","1","453.64","0","10","45.36","499","2024-01-19 20:40:16","2024-01-19 20:40:16","","");
INSERT INTO product_sales VALUES("2","1","2","","","","1","0","1","1144.55","0","10","114.45","1259","2024-01-19 20:40:16","2024-01-19 20:40:16","","");
INSERT INTO product_sales VALUES("3","2","16","","","","1","0","1","109","0","0","0","109","2024-01-19 20:44:41","2024-01-19 20:44:41","","");
INSERT INTO product_sales VALUES("4","2","18","","","","1","0","1","544.55","0","10","54.45","599","2024-01-19 20:44:41","2024-01-19 20:44:41","","");
INSERT INTO product_sales VALUES("5","2","9","","","","1","0","1","559","0","0","0","559","2024-01-19 20:44:41","2024-01-19 20:44:41","","");
INSERT INTO product_sales VALUES("6","2","4","","","","1","0","1","954.55","0","10","95.45","1050","2024-01-19 20:44:41","2024-01-19 20:44:41","","");
INSERT INTO product_sales VALUES("7","2","3","","","","2","0","1","318.18","0","10","63.64","700","2024-01-19 20:44:41","2024-01-19 20:44:41","","");
INSERT INTO product_sales VALUES("8","3","18","","","","1","0","1","544.55","0","10","54.45","599","2024-01-19 20:48:33","2024-01-19 20:48:33","","");
INSERT INTO product_sales VALUES("9","3","23","","","","1","0","1","577","0","0","0","577","2024-01-19 20:48:33","2024-01-19 20:48:33","","");
INSERT INTO product_sales VALUES("10","3","27","","","","3","0","1","2","0","0","0","6","2024-01-19 20:48:33","2024-01-19 20:48:33","","");
INSERT INTO product_sales VALUES("11","4","7","","","","1","0","1","908.18","0","10","90.82","999","2024-01-19 20:52:42","2024-01-19 20:53:31","","");
INSERT INTO product_sales VALUES("12","4","17","","","","1","0","1","499","0","0","0","499","2024-01-19 20:52:42","2024-01-19 20:53:31","","");
INSERT INTO product_sales VALUES("13","4","20","","","","1","0","1","499","0","0","0","499","2024-01-19 20:52:42","2024-01-19 20:53:31","","");
INSERT INTO product_sales VALUES("14","5","2","","","","1","0","1","1144.55","0","10","114.45","1259","2024-02-10 12:22:24","2024-02-10 12:22:24","","");
INSERT INTO product_sales VALUES("15","6","1","","","","1","0","1","1181.81","0","10","118.18","1299.99","2024-02-25 13:49:51","2024-02-25 13:49:51","","");
INSERT INTO product_sales VALUES("16","7","1","","","","2","0","1","1181.81","0","10","236.36","2599.98","2024-02-25 13:50:13","2024-02-25 13:50:13","","");
INSERT INTO product_sales VALUES("17","8","2","","","","1","0","1","1144.55","0","10","114.45","1259","2024-02-28 11:27:44","2024-02-28 11:27:44","","");
INSERT INTO product_sales VALUES("18","8","1","","","","1","1","1","1181.81","0","10","118.18","1299.99","2024-02-28 11:27:44","2024-03-24 13:08:23","","");
INSERT INTO product_sales VALUES("19","9","3","","","","1","0","1","318.18","0","10","31.82","350","2024-04-21 11:01:43","2024-04-21 11:01:43","","");
INSERT INTO product_sales VALUES("25","13","3","","","","1","0","1","318.18","0","10","31.82","350","2024-04-28 12:15:44","2024-04-28 12:15:44","","");
INSERT INTO product_sales VALUES("26","13","19","","","","1","0","1","962.73","0","10","96.27","1059","2024-04-28 12:15:44","2024-04-28 12:15:44","","");
INSERT INTO product_sales VALUES("27","14","5","","","","1","1","1","1046.35","0","10","104.64","1150.99","2024-04-29 18:29:56","2024-04-29 18:30:38","","");
INSERT INTO product_sales VALUES("28","14","4","","","","1","0","1","954.55","0","10","95.45","1050","2024-04-29 18:29:56","2024-04-29 18:29:56","","");
INSERT INTO product_sales VALUES("29","14","3","","","","1","1","1","318.18","0","10","31.82","350","2024-04-29 18:29:56","2024-04-29 18:30:38","","");
INSERT INTO product_sales VALUES("30","14","2","","","","1","0","1","1136.36","0","10","113.64","1250","2024-04-29 18:29:56","2024-04-29 18:29:56","","");
INSERT INTO product_sales VALUES("31","15","20","","","","1","0","1","499","0","0","0","499","2024-05-05 11:19:02","2024-05-05 11:19:02","","");
INSERT INTO product_sales VALUES("37","20","2","","","","1","0","1","1136.36","0","10","113.64","1250","2024-05-05 17:29:05","2024-05-05 17:29:05","","");
INSERT INTO product_sales VALUES("38","20","1","","","","1","0","1","1181.81","0","10","118.18","1299.99","2024-05-05 17:29:05","2024-05-05 17:29:05","","");
INSERT INTO product_sales VALUES("40","22","7","","","","1","0","1","909.08","0","10","90.91","999.99","2024-05-08 14:08:51","2024-05-08 14:08:51","","");
INSERT INTO product_sales VALUES("41","22","3","","","","1","0","1","318.18","0","10","31.82","350","2024-05-08 14:08:51","2024-05-08 14:08:51","","");
INSERT INTO product_sales VALUES("42","23","1","","","","1","0","1","1181.81","0","10","118.18","1299.99","2024-05-19 14:24:23","2024-05-19 14:24:23","","");
INSERT INTO product_sales VALUES("43","24","8","","","","1","0","1","1181.82","0","10","118.18","1300","2024-05-19 14:25:30","2024-05-19 14:25:30","","");
INSERT INTO product_sales VALUES("44","25","8","","","","1","0","1","1181.82","0","10","118.18","1300","2024-05-19 14:30:55","2024-05-19 14:30:55","","");
INSERT INTO product_sales VALUES("49","28","4","","","","1","0","1","954.55","0","10","95.45","1050","2024-05-21 13:32:49","2024-05-21 13:32:49","","");
INSERT INTO product_sales VALUES("50","29","2","","","","1","0","1","1136.36","0","10","113.64","1250","2024-06-03 12:26:51","2024-06-03 12:26:51","","");
INSERT INTO product_sales VALUES("51","29","1","","","","1","0","1","1181.81","0","10","118.18","1299.99","2024-06-03 12:26:51","2024-06-03 12:26:51","","");
INSERT INTO product_sales VALUES("52","30","4","","","","1","0","1","954.55","0","10","95.45","1050","2024-06-03 17:30:15","2024-06-03 17:30:15","","");
INSERT INTO product_sales VALUES("53","30","2","","","","1","0","1","1136.36","0","10","113.64","1250","2024-06-03 17:30:15","2024-06-03 17:30:15","","");
INSERT INTO product_sales VALUES("54","31","23","","","","1","0","1","577","0","0","0","577","2024-06-03 17:30:58","2024-06-03 17:30:58","","");
INSERT INTO product_sales VALUES("55","32","1","","","","1","0","1","1181.81","0","10","118.18","1299.99","2024-06-20 13:54:56","2024-06-20 13:54:56","","");
INSERT INTO product_sales VALUES("56","33","1","","","","1","1","1","1181.81","0","10","118.18","1299.99","2024-06-26 13:01:15","2024-06-26 13:01:42","","");
INSERT INTO product_sales VALUES("59","36","23","","","","1","0","1","577","0","0","0","577","2024-07-11 12:10:41","2024-07-11 12:10:41","","");
INSERT INTO product_sales VALUES("61","38","1","","","","1","0","1","1181.81","0","10","118.18","1299.99","2024-07-18 11:36:30","2024-07-18 11:36:30","","");
INSERT INTO product_sales VALUES("62","39","33","","","1003","1","0","1","250","0","0","0","250","2024-07-18 13:59:13","2024-07-18 13:59:13","","");
INSERT INTO product_sales VALUES("63","40","33","","","2001","1","0","1","250","0","0","0","250","2024-07-18 14:01:45","2024-07-18 14:01:45","","");
INSERT INTO product_sales VALUES("65","42","23","","","","1","0","1","577","0","0","0","577","2024-08-11 11:06:29","2024-08-11 11:28:06","1","1");
INSERT INTO product_sales VALUES("66","43","18","","","","1","0","1","544.55","0","10","54.45","599","2024-08-11 11:37:22","2024-08-11 11:37:38","","1");
INSERT INTO product_sales VALUES("68","45","2","","","","1","0","1","1136.36","0","10","113.64","1250","2024-08-11 11:48:52","2024-08-11 11:48:52","","");
INSERT INTO product_sales VALUES("69","45","3","","","","1","0","1","318.18","0","10","31.82","350","2024-08-11 11:48:52","2024-08-11 11:48:52","","");
INSERT INTO product_sales VALUES("70","46","1","","","","1","0","1","1181.81","0","10","118.18","1299.99","2024-08-26 05:26:16","2024-08-26 05:26:16","","");
INSERT INTO product_sales VALUES("71","47","4","","","","1","0","1","954.55","0","10","95.45","1050","2024-08-26 05:26:30","2024-08-26 05:26:30","","");
INSERT INTO product_sales VALUES("74","50","3","","","","1","0","1","318.18","0","10","31.82","350","2024-08-26 05:29:29","2024-08-26 05:29:29","","");
INSERT INTO product_sales VALUES("75","51","34","","2","null","1","0","1","150","0","0","0","150","2024-11-24 15:02:58","2024-11-24 15:02:58","","");
INSERT INTO product_sales VALUES("76","52","34","","2","null","1","0","1","150","0","0","0","150","2024-11-24 15:04:25","2024-11-24 16:44:05","","");
INSERT INTO product_sales VALUES("77","53","33","","","1001","1","0","1","250","0","0","0","250","2024-11-24 16:47:02","2024-11-24 16:47:26","","");
INSERT INTO product_sales VALUES("78","54","23","","","","1","0","1","577","0","0","0","577","2024-11-27 15:14:18","2024-11-27 15:14:18","","");
INSERT INTO product_sales VALUES("79","55","23","","","","1","0","1","577","0","0","0","577","2024-11-27 17:04:18","2024-11-27 17:04:18","","");
INSERT INTO product_sales VALUES("80","56","17","","","","1","0","1","499","0","0","0","499","2024-11-27 17:05:22","2024-11-27 17:05:22","","");
INSERT INTO product_sales VALUES("81","56","20","","","","1","0","1","499","0","0","0","499","2024-11-27 17:05:22","2024-11-27 17:05:22","","");
INSERT INTO product_sales VALUES("82","57","17","","","","1","0","1","499","0","0","0","499","2024-11-27 17:07:26","2024-11-27 17:07:26","","");
INSERT INTO product_sales VALUES("83","57","20","","","","1","0","1","499","0","0","0","499","2024-11-27 17:07:26","2024-11-27 17:07:26","","");
INSERT INTO product_sales VALUES("84","58","17","","","","1","0","1","499","0","0","0","499","2024-11-27 17:18:04","2024-11-27 17:18:04","","");
INSERT INTO product_sales VALUES("85","58","20","","","","1","0","1","499","0","0","0","499","2024-11-27 17:18:04","2024-11-27 17:18:04","","");
INSERT INTO product_sales VALUES("86","59","17","","","","1","0","1","499","0","0","0","499","2024-11-27 17:22:04","2024-11-27 17:22:04","","");
INSERT INTO product_sales VALUES("87","59","20","","","","1","0","1","499","0","0","0","499","2024-11-27 17:22:04","2024-11-27 17:22:04","","");
INSERT INTO product_sales VALUES("88","60","17","","","","1","0","1","499","0","0","0","499","2024-11-27 17:22:37","2024-11-27 17:22:37","","");
INSERT INTO product_sales VALUES("89","60","20","","","","1","0","1","499","0","0","0","499","2024-11-27 17:22:37","2024-11-27 17:22:37","","");
INSERT INTO product_sales VALUES("90","61","17","","","","1","0","1","499","0","0","0","499","2024-11-27 17:41:16","2024-11-27 17:41:16","","");
INSERT INTO product_sales VALUES("91","61","20","","","","1","0","1","499","0","0","0","499","2024-11-27 17:41:16","2024-11-27 17:41:16","","");
INSERT INTO product_sales VALUES("92","62","17","","","","1","0","1","499","0","0","0","499","2024-11-27 17:41:59","2024-11-27 17:41:59","","");
INSERT INTO product_sales VALUES("93","62","20","","","","1","0","1","499","0","0","0","499","2024-11-27 17:41:59","2024-11-27 17:41:59","","");
INSERT INTO product_sales VALUES("94","63","17","","","","1","0","1","499","0","0","0","499","2024-11-27 17:43:51","2024-11-27 17:43:51","","");
INSERT INTO product_sales VALUES("95","63","20","","","","1","0","1","499","0","0","0","499","2024-11-27 17:43:51","2024-11-27 17:43:51","","");
INSERT INTO product_sales VALUES("96","64","17","","","","1","0","1","499","0","0","0","499","2024-11-27 17:46:50","2024-11-27 17:46:50","","");
INSERT INTO product_sales VALUES("97","64","20","","","","1","0","1","499","0","0","0","499","2024-11-27 17:46:50","2024-11-27 17:46:50","","");
INSERT INTO product_sales VALUES("98","65","17","","","","1","0","1","499","0","0","0","499","2024-11-27 17:48:19","2024-11-27 17:48:19","","");
INSERT INTO product_sales VALUES("99","65","20","","","","1","0","1","499","0","0","0","499","2024-11-27 17:48:20","2024-11-27 17:48:20","","");
INSERT INTO product_sales VALUES("100","66","17","","","","1","0","1","499","0","0","0","499","2024-11-27 17:49:47","2024-11-27 17:49:47","","");
INSERT INTO product_sales VALUES("101","66","20","","","","1","0","1","499","0","0","0","499","2024-11-27 17:49:47","2024-11-27 17:49:47","","");
INSERT INTO product_sales VALUES("102","67","17","","","","1","0","1","499","0","0","0","499","2024-11-27 17:49:55","2024-11-27 17:49:55","","");
INSERT INTO product_sales VALUES("103","67","20","","","","1","0","1","499","0","0","0","499","2024-11-27 17:49:55","2024-11-27 17:49:55","","");
INSERT INTO product_sales VALUES("104","68","17","","","","1","0","1","499","0","0","0","499","2024-11-27 17:50:34","2024-11-27 17:50:34","","");
INSERT INTO product_sales VALUES("105","68","20","","","","1","0","1","499","0","0","0","499","2024-11-27 17:50:34","2024-11-27 17:50:34","","");
INSERT INTO product_sales VALUES("106","69","17","","","","1","0","1","499","0","0","0","499","2024-11-27 17:51:28","2024-11-27 17:51:28","","");
INSERT INTO product_sales VALUES("107","69","20","","","","1","0","1","499","0","0","0","499","2024-11-27 17:51:28","2024-11-27 17:51:28","","");
INSERT INTO product_sales VALUES("108","70","23","","","","1","0","1","577","0","0","0","577","2024-11-27 17:52:19","2024-11-27 17:52:19","","");
INSERT INTO product_sales VALUES("109","71","23","","","","1","0","1","577","0","0","0","577","2024-11-28 22:23:12","2024-11-28 22:23:12","","");
INSERT INTO product_sales VALUES("110","72","23","","","","1","0","1","577","0","0","0","577","2024-11-28 22:26:53","2024-11-28 22:26:53","","");
INSERT INTO product_sales VALUES("111","73","4","","","null","1","0","1","954.55","0","10","95.45","1050","2024-12-03 13:02:11","2024-12-03 13:02:11","","");
INSERT INTO product_sales VALUES("112","74","4","","","null","1","0","1","954.55","0","10","95.45","1050","2024-12-03 14:10:16","2024-12-03 14:10:16","","");
INSERT INTO product_sales VALUES("113","75","4","","","null","1","0","1","954.55","0","10","95.45","1050","2024-12-03 14:12:23","2024-12-03 14:12:23","","");
INSERT INTO product_sales VALUES("114","76","4","","","null","1","0","1","954.55","0","10","95.45","1050","2024-12-03 14:12:44","2024-12-03 14:12:44","","");
INSERT INTO product_sales VALUES("115","77","4","","","null","1","0","1","954.55","0","10","95.45","1050","2024-12-03 14:19:27","2024-12-03 14:19:27","","");
INSERT INTO product_sales VALUES("116","78","4","","","null","1","0","1","954.55","0","10","95.45","1050","2024-12-03 14:19:51","2024-12-03 14:19:51","","");
INSERT INTO product_sales VALUES("117","79","4","","","null","1","0","1","954.55","0","10","95.45","1050","2024-12-03 14:20:09","2024-12-03 14:20:09","","");
INSERT INTO product_sales VALUES("118","80","4","","","null","1","0","1","954.55","0","10","95.45","1050","2024-12-03 14:29:58","2024-12-03 14:29:58","","");
INSERT INTO product_sales VALUES("119","81","4","","","null","1","0","1","954.55","0","10","95.45","1050","2024-12-03 14:35:29","2024-12-03 14:35:29","","");
INSERT INTO product_sales VALUES("120","82","4","","","null","1","0","1","954.55","0","10","95.45","1050","2024-12-03 14:37:27","2024-12-03 14:37:27","","");
INSERT INTO product_sales VALUES("121","83","4","","","null","1","0","1","954.55","0","10","95.45","1050","2024-12-03 14:40:06","2024-12-03 14:40:06","","");
INSERT INTO product_sales VALUES("122","84","4","","","null","1","0","1","954.55","0","10","95.45","1050","2024-12-03 14:45:09","2024-12-03 14:45:09","","");
INSERT INTO product_sales VALUES("123","85","4","","","null","1","0","1","954.55","0","10","95.45","1050","2024-12-03 15:37:07","2024-12-03 15:37:07","","");
INSERT INTO product_sales VALUES("124","86","4","","","null","1","0","1","954.55","0","10","95.45","1050","2024-12-03 15:38:02","2024-12-03 15:38:02","","");
INSERT INTO product_sales VALUES("125","87","4","","","null","1","0","1","954.55","0","10","95.45","1050","2024-12-03 15:40:48","2024-12-03 15:40:48","","");
INSERT INTO product_sales VALUES("126","88","4","","","null","1","0","1","954.55","0","10","95.45","1050","2024-12-03 18:12:13","2024-12-03 18:12:13","","");
INSERT INTO product_sales VALUES("127","89","4","","","null","1","0","1","954.55","0","10","95.45","1050","2024-12-03 18:13:42","2024-12-03 18:13:42","","");
INSERT INTO product_sales VALUES("128","90","4","","","null","1","0","1","954.55","0","10","95.45","1050","2024-12-03 18:15:05","2024-12-03 18:15:05","","");
INSERT INTO product_sales VALUES("129","91","4","","","null","1","0","1","954.55","0","10","95.45","1050","2024-12-03 18:19:07","2024-12-03 18:19:07","","");
INSERT INTO product_sales VALUES("130","92","4","","","null","1","0","1","954.55","0","10","95.45","1050","2024-12-03 18:19:57","2024-12-03 18:19:57","","");
INSERT INTO product_sales VALUES("131","93","4","","","null","1","0","1","954.55","0","10","95.45","1050","2024-12-04 16:30:22","2024-12-04 16:30:22","","");
INSERT INTO product_sales VALUES("132","94","4","","","null","1","0","1","954.55","0","10","95.45","1050","2024-12-04 16:39:03","2024-12-04 16:39:03","","");
INSERT INTO product_sales VALUES("133","95","4","","","null","1","0","1","954.55","0","10","95.45","1050","2024-12-04 16:41:29","2024-12-04 16:41:29","","");
INSERT INTO product_sales VALUES("134","96","4","","","null","1","0","1","954.55","0","10","95.45","1050","2024-12-04 16:41:57","2024-12-04 16:41:57","","");
INSERT INTO product_sales VALUES("135","97","4","","","null","1","0","1","954.55","0","10","95.45","1050","2024-12-04 16:54:22","2024-12-04 16:54:22","","");
INSERT INTO product_sales VALUES("136","98","4","","","null","1","0","1","954.55","0","10","95.45","1050","2024-12-04 16:56:38","2024-12-04 16:56:38","","");
INSERT INTO product_sales VALUES("137","99","4","","","null","1","0","1","954.55","0","10","95.45","1050","2024-12-04 16:57:28","2024-12-04 16:57:28","","");
INSERT INTO product_sales VALUES("138","100","4","","","null","1","0","1","954.55","0","10","95.45","1050","2024-12-04 16:57:51","2024-12-04 16:57:51","","");
INSERT INTO product_sales VALUES("139","101","4","","","null","1","0","1","954.55","0","10","95.45","1050","2024-12-04 17:58:35","2024-12-04 17:58:35","","");
INSERT INTO product_sales VALUES("140","102","4","","","null","1","0","1","954.55","0","10","95.45","1050","2024-12-04 17:59:15","2024-12-04 17:59:15","","");
INSERT INTO product_sales VALUES("141","103","4","","","null","1","0","1","954.55","0","10","95.45","1050","2024-12-04 18:04:35","2024-12-04 18:04:35","","");
INSERT INTO product_sales VALUES("142","104","4","","","null","1","0","1","954.55","0","10","95.45","1050","2024-12-04 18:05:20","2024-12-04 18:05:20","","");
INSERT INTO product_sales VALUES("143","105","4","","","null","1","0","1","954.55","0","10","95.45","1050","2024-12-04 18:05:43","2024-12-04 18:05:43","","");
INSERT INTO product_sales VALUES("144","106","4","","","null","1","0","1","954.55","0","10","95.45","1050","2024-12-04 18:06:07","2024-12-04 18:06:07","","");
INSERT INTO product_sales VALUES("145","107","4","","","null","1","0","1","954.55","0","10","95.45","1050","2024-12-04 18:08:52","2024-12-04 18:08:52","","");
INSERT INTO product_sales VALUES("146","108","23","","","null","1","0","1","577","0","0","0","577","2024-12-06 12:00:19","2024-12-06 12:00:19","","");
INSERT INTO product_sales VALUES("147","109","23","","","null","1","0","1","577","0","0","0","577","2024-12-06 12:17:40","2024-12-06 12:17:40","","");
INSERT INTO product_sales VALUES("148","110","23","","","null","1","0","1","577","0","0","0","577","2024-12-07 12:40:03","2024-12-07 12:40:03","","");
INSERT INTO product_sales VALUES("149","111","23","","","null","1","0","1","577","0","0","0","577","2024-12-08 11:29:55","2024-12-08 11:29:55","","");
INSERT INTO product_sales VALUES("150","112","1","","","null,null","1","0","1","1181.81","0","10","118.18","1299.99","2024-12-17 10:24:18","2024-12-17 10:24:18","","");
INSERT INTO product_sales VALUES("151","113","27","","","null,null","1","0","1","1.29","0","0","0","1.29","2024-12-17 10:26:31","2024-12-17 10:26:31","","");
INSERT INTO product_sales VALUES("152","114","4","","","null,null","1","0","1","859.09","0","10","85.91","945","2024-12-18 11:17:45","2024-12-18 11:17:45","","");
INSERT INTO product_sales VALUES("153","115","39","","","null","1","0","1","810","0","0","0","810","2024-12-19 11:31:08","2024-12-19 11:31:08","","");
INSERT INTO product_sales VALUES("154","116","42","","","null","1","0","1","27","0","0","0","27","2024-12-19 11:43:03","2024-12-19 11:43:03","","");
INSERT INTO product_sales VALUES("156","118","1","","","null,null","1","0","1","1063.63","0","10","106.36","1169.99","2024-12-23 12:10:43","2024-12-23 12:10:43","","");
INSERT INTO product_sales VALUES("157","119","23","","","null","1","0","1","577","0","0","0","577","2024-12-29 00:26:48","2024-12-29 00:26:48","","");
INSERT INTO product_sales VALUES("158","120","1","","","null,null","1","0","1","1063.63","0","10","106.36","1169.99","2024-12-29 12:35:35","2024-12-29 12:35:35","","");
INSERT INTO product_sales VALUES("159","121","1","","","null,null","1","0","1","1063.63","0","10","106.36","1169.99","2024-12-29 12:39:47","2024-12-29 12:39:47","","");
INSERT INTO product_sales VALUES("160","122","4","","","null,null","1","0","1","859.09","0","10","85.91","945","2024-12-29 12:40:02","2024-12-29 12:40:02","","");
INSERT INTO product_sales VALUES("161","123","1","","","null,null","1","0","1","1063.63","0","10","106.36","1169.99","2024-12-29 12:44:14","2024-12-29 12:44:14","","");
INSERT INTO product_sales VALUES("162","124","1","","","null,null","1","0","1","1063.63","0","10","106.36","1169.99","2024-12-29 12:45:36","2024-12-29 12:45:36","","");
INSERT INTO product_sales VALUES("163","125","1","","","null,null","1","0","1","1063.63","0","10","106.36","1169.99","2024-12-29 13:06:00","2024-12-29 13:06:00","","");
INSERT INTO product_sales VALUES("164","126","1","","","null,null","1","0","1","1063.63","0","10","106.36","1169.99","2024-12-29 13:08:27","2024-12-29 13:08:27","","");
INSERT INTO product_sales VALUES("165","127","1","","","null,null","1","0","1","1063.63","0","10","106.36","1169.99","2024-12-29 13:09:44","2024-12-29 13:09:44","","");
INSERT INTO product_sales VALUES("166","128","1","","","null,null","1","0","1","1063.63","0","10","106.36","1169.99","2024-12-29 13:10:46","2024-12-29 13:10:46","","");
INSERT INTO product_sales VALUES("167","129","1","","","null,null","1","0","1","1063.63","0","10","106.36","1169.99","2024-12-29 14:03:03","2024-12-29 14:03:03","","");
INSERT INTO product_sales VALUES("168","130","1","","","null,null","1","0","1","1063.63","0","10","106.36","1169.99","2024-12-29 14:42:44","2024-12-29 14:42:44","","");
INSERT INTO product_sales VALUES("169","131","1","","","null,null","1","0","1","1063.63","0","10","106.36","1169.99","2024-12-29 15:51:14","2024-12-29 15:51:14","","");
INSERT INTO product_sales VALUES("170","132","1","","","null,null","1","0","1","1063.63","0","10","106.36","1169.99","2024-12-29 17:48:02","2024-12-29 17:48:02","","");
INSERT INTO product_sales VALUES("171","133","1","","","null,null","1","0","1","1063.63","0","10","106.36","1169.99","2024-12-29 17:50:21","2024-12-29 17:50:21","","");
INSERT INTO product_sales VALUES("172","134","1","","","null,null","1","0","1","1063.63","0","10","106.36","1169.99","2024-12-30 12:28:22","2024-12-30 12:28:22","","");
INSERT INTO product_sales VALUES("173","135","1","","","null,null","1","0","1","1063.63","0","10","106.36","1169.99","2024-12-30 12:29:46","2024-12-30 12:29:46","","");
INSERT INTO product_sales VALUES("174","136","1","","","null,null","1","0","1","1063.63","0","10","106.36","1169.99","2024-12-30 12:30:58","2024-12-30 12:30:58","","");
INSERT INTO product_sales VALUES("175","137","1","","","null,null","1","0","1","1063.63","0","10","106.36","1169.99","2024-12-30 12:31:31","2024-12-30 12:31:31","","");
INSERT INTO product_sales VALUES("176","138","1","","","null,null","1","0","1","1181.81","0","10","118.18","1299.99","2025-01-01 12:50:49","2025-01-01 12:50:49","","");
INSERT INTO product_sales VALUES("177","139","1","","","null,null","1","0","1","1181.81","0","10","118.18","1299.99","2025-01-01 14:37:52","2025-01-01 14:37:52","","");
INSERT INTO product_sales VALUES("178","140","51","","","obb2,obb2","1","0","1","100","0","0","0","100","2025-01-09 12:40:48","2025-01-09 12:40:48","","");
INSERT INTO product_sales VALUES("179","141","23","","","null,null","1","0","1","577","0","0","0","577","2025-01-12 12:16:32","2025-01-12 12:16:32","","");
INSERT INTO product_sales VALUES("180","142","27","","","null,null","1","0","1","1.29","0","0","0","1.29","2025-01-12 12:19:04","2025-01-12 12:19:04","","");
INSERT INTO product_sales VALUES("181","143","23","","","null,null","1","0","1","577","0","0","0","577","2025-01-12 12:19:56","2025-01-12 12:19:56","","");
INSERT INTO product_sales VALUES("182","144","53","","","null,null","1","0","1","100","0","0","0","100","2025-01-12 12:22:10","2025-01-12 12:22:10","","");
INSERT INTO product_sales VALUES("183","145","53","","","null,null","1","0","1","100","0","0","0","100","2025-01-12 12:23:39","2025-01-12 12:23:39","","");
INSERT INTO product_sales VALUES("184","146","53","","","null,null","1","0","1","100","0","0","0","100","2025-01-12 12:25:38","2025-01-12 12:25:38","","");
INSERT INTO product_sales VALUES("185","147","53","","","null","1","0","1","100","0","0","0","100","2025-01-12 13:08:45","2025-01-12 13:08:45","","");
INSERT INTO product_sales VALUES("186","148","54","","","aa2,aa2,aa1","2","0","1","100","0","0","0","200","2025-01-12 13:40:34","2025-01-12 13:40:34","","");
INSERT INTO product_sales VALUES("189","160","55","","11","dd8,dd8,dd5","2","0","1","100","0","0","0","200","2025-01-13 15:56:57","2025-01-13 15:56:57","","");
INSERT INTO product_sales VALUES("190","160","55","","5","dd6,dd6","1","0","1","100","0","0","0","100","2025-01-13 15:56:57","2025-01-13 15:56:57","","");
INSERT INTO product_sales VALUES("191","161","55","","11","dd8,dd8,dd5","2","0","1","100","0","0","0","200","2025-01-13 15:59:44","2025-01-13 15:59:44","","");
INSERT INTO product_sales VALUES("192","161","55","","5","dd6,dd6","1","0","1","100","0","0","0","100","2025-01-13 15:59:44","2025-01-13 15:59:44","","");
INSERT INTO product_sales VALUES("193","162","55","","11","dd8,dd8","2","0","1","100","0","0","0","200","2025-01-13 16:00:00","2025-01-13 16:00:00","","");
INSERT INTO product_sales VALUES("194","162","55","","5","dd6,dd6","1","0","1","100","0","0","0","100","2025-01-13 16:00:00","2025-01-13 16:00:00","","");
INSERT INTO product_sales VALUES("195","163","56","","","ee2,ee2,ee1","2","0","1","100","0","0","0","200","2025-01-14 14:06:57","2025-01-14 14:06:57","","");
INSERT INTO product_sales VALUES("198","166","53","","","null","1","0","1","100","0","0","0","100","2025-01-15 10:01:32","2025-01-15 10:01:32","","");
INSERT INTO product_sales VALUES("200","168","55","","5","dd2,dd2","1","0","1","100","0","0","0","100","2025-01-15 12:46:11","2025-01-15 12:46:11","","");
INSERT INTO product_sales VALUES("203","172","62","","","ee1,ee1,ee2","2","0","1","10","0","0","0","20","2025-01-15 15:58:41","2025-01-15 15:58:41","","");
INSERT INTO product_sales VALUES("204","173","55","","11","aa2,aa2","1","0","1","100","0","0","0","100","2025-01-19 17:11:38","2025-01-19 17:11:38","","");
INSERT INTO product_sales VALUES("205","174","64","","","bb2,bb2","1","0","1","100","0","0","0","100","2025-01-19 17:18:31","2025-01-19 17:18:31","","");
INSERT INTO product_sales VALUES("218","190","79","","","null,null","1","0","1","100","0","0","0","100","2025-01-21 10:45:00","2025-01-21 10:45:00","","");
INSERT INTO product_sales VALUES("219","191","55","","5","dd20,dd20","1","0","1","100","0","10","10","110","2025-01-21 14:17:16","2025-01-21 14:17:16","","");
INSERT INTO product_sales VALUES("220","191","79","","","null,null","1","0","1","100","0","0","0","100","2025-01-21 14:17:16","2025-01-21 14:17:16","","");
INSERT INTO product_sales VALUES("221","191","80","","5","qq4,qq4","1","0","1","100","0","0","0","100","2025-01-21 14:17:17","2025-01-21 14:17:17","","");
INSERT INTO product_sales VALUES("224","194","90","","","null,null","1","0","1","100","0","0","0","100","2025-01-26 23:35:36","2025-01-26 23:35:36","","");
INSERT INTO product_sales VALUES("225","195","90","","","null,null","1","0","1","100","0","0","0","100","2025-01-27 09:26:30","2025-01-27 09:26:30","","");
INSERT INTO product_sales VALUES("226","196","6","","","null,null","1","0","1","1111.99","0","0","0","1111.99","2025-01-27 09:28:43","2025-01-27 09:28:43","","");



CREATE TABLE `product_transfer` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `transfer_id` int NOT NULL,
  `product_id` int NOT NULL,
  `product_batch_id` int DEFAULT NULL,
  `variant_id` int DEFAULT NULL,
  `imei_number` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `qty` double NOT NULL,
  `purchase_unit_id` int NOT NULL,
  `net_unit_cost` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO product_transfer VALUES("11","11","23","","","","1","1","439","0","0","439","2024-05-28 15:05:50","2024-05-28 15:05:50");
INSERT INTO product_transfer VALUES("12","12","20","","","","1","1","399","0","0","399","2024-05-28 15:07:14","2024-05-28 15:07:14");
INSERT INTO product_transfer VALUES("13","13","34","","2","null","1","1","100","0","0","100","2024-11-24 15:11:28","2024-11-24 15:11:28");
INSERT INTO product_transfer VALUES("14","14","80","","10","null","2","1","10","0","0","20","2025-01-21 14:57:02","2025-01-21 14:57:02");
INSERT INTO product_transfer VALUES("15","15","80","","10","null","2","1","10","0","0","20","2025-01-22 11:42:18","2025-01-22 11:42:18");



CREATE TABLE `product_variants` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `variant_id` int NOT NULL,
  `position` int NOT NULL,
  `item_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `additional_cost` double DEFAULT NULL,
  `additional_price` double DEFAULT NULL,
  `qty` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO product_variants VALUES("1","34","1","1","s/red-09759418","","","0","2024-11-24 14:57:18","2024-11-24 14:57:18");
INSERT INTO product_variants VALUES("2","34","2","2","s/blue-09759418","","","8","2024-11-24 14:57:18","2024-11-24 16:44:05");
INSERT INTO product_variants VALUES("3","34","3","3","m/red-09759418","","","0","2024-11-24 14:57:18","2024-11-24 14:57:18");
INSERT INTO product_variants VALUES("4","34","4","4","m/blue-09759418","","","0","2024-11-24 14:57:18","2024-11-24 14:57:18");
INSERT INTO product_variants VALUES("5","36","5","1","red-51234109","","","1","2024-12-19 11:23:34","2024-12-19 15:32:43");
INSERT INTO product_variants VALUES("6","36","6","2","green-51234109","","","0","2024-12-19 11:23:34","2024-12-19 11:23:34");
INSERT INTO product_variants VALUES("7","36","7","3","blue-51234109","","","0","2024-12-19 11:23:34","2024-12-19 11:23:34");
INSERT INTO product_variants VALUES("8","37","5","1","red-97067049","","","1","2024-12-19 11:25:08","2024-12-19 15:32:43");
INSERT INTO product_variants VALUES("9","37","6","2","green-97067049","","","0","2024-12-19 11:25:08","2024-12-19 11:25:08");
INSERT INTO product_variants VALUES("10","37","7","3","blue-97067049","","","0","2024-12-19 11:25:08","2024-12-19 11:25:08");
INSERT INTO product_variants VALUES("11","38","5","1","red-22307439","","","1","2024-12-19 11:26:10","2024-12-19 15:32:43");
INSERT INTO product_variants VALUES("12","38","6","2","green-22307439","","","0","2024-12-19 11:26:10","2024-12-19 11:26:10");
INSERT INTO product_variants VALUES("13","38","7","3","blue-22307439","","","0","2024-12-19 11:26:10","2024-12-19 11:26:10");
INSERT INTO product_variants VALUES("14","45","8","1","Black/Blue-96392154","","","0","2025-01-08 14:43:52","2025-01-08 18:48:13");
INSERT INTO product_variants VALUES("15","47","5","1","Red-91123377","","","0","2025-01-08 15:08:46","2025-01-08 18:47:51");
INSERT INTO product_variants VALUES("16","47","7","2","Blue-91123377","","","0","2025-01-08 15:08:46","2025-01-08 15:08:46");
INSERT INTO product_variants VALUES("17","47","9","3","White-91123377","","","0","2025-01-08 15:08:46","2025-01-08 15:08:46");
INSERT INTO product_variants VALUES("18","48","10","1","Silver-22171633","","","2","2025-01-08 18:50:34","2025-01-08 18:51:25");
INSERT INTO product_variants VALUES("19","48","11","2","Black-22171633","","","0","2025-01-08 18:50:34","2025-01-12 12:09:39");
INSERT INTO product_variants VALUES("20","49","12","1","Sky-09220168","","","0","2025-01-08 18:56:54","2025-01-12 12:09:30");
INSERT INTO product_variants VALUES("21","49","13","2","Inherit-09220168","","","0","2025-01-08 18:56:54","2025-01-11 09:25:35");
INSERT INTO product_variants VALUES("22","50","11","1","Black-61170981","","","0","2025-01-09 10:32:16","2025-01-12 12:09:24");
INSERT INTO product_variants VALUES("23","50","14","2","Ash-61170981","","","2","2025-01-09 10:32:16","2025-01-11 10:22:59");
INSERT INTO product_variants VALUES("24","55","5","1","Red-27009213","","","0","2025-01-12 13:20:38","2025-01-21 14:17:16");
INSERT INTO product_variants VALUES("25","55","11","2","Black-27009213","","","0","2025-01-12 13:20:38","2025-01-19 17:11:38");
INSERT INTO product_variants VALUES("26","63","11","1","Black-45631377","","","2","2025-01-17 00:28:46","2025-01-17 00:30:53");
INSERT INTO product_variants VALUES("27","63","10","2","Silver-45631377","","","2","2025-01-17 00:28:46","2025-01-17 00:30:53");
INSERT INTO product_variants VALUES("28","70","15","1","Brown-21173560","","","0","2025-01-20 10:53:13","2025-01-20 12:16:31");
INSERT INTO product_variants VALUES("29","70","11","2","Black-21173560","","","0","2025-01-20 10:53:13","2025-01-20 10:53:13");
INSERT INTO product_variants VALUES("30","80","10","1","Silver-99082603","","","4","2025-01-21 14:12:50","2025-01-21 14:15:41");
INSERT INTO product_variants VALUES("31","80","5","2","Red-99082603","","","1","2025-01-21 14:12:50","2025-01-21 14:17:16");
INSERT INTO product_variants VALUES("32","81","1","1","S/Red-9999","0","0","0","","");
INSERT INTO product_variants VALUES("33","81","16","2","S/Green-9999","0","0","0","","");
INSERT INTO product_variants VALUES("34","81","3","3","M/Red-9999","0","0","0","","");
INSERT INTO product_variants VALUES("35","81","17","4","M/Green-9999","0","0","0","","");
INSERT INTO product_variants VALUES("36","81","18","5","L/Red-9999","5","10","0","","");
INSERT INTO product_variants VALUES("37","81","19","6","L/Green-9999","5","10","0","","");
INSERT INTO product_variants VALUES("38","83","1","1","S/Red-9999","0","0","0","","");
INSERT INTO product_variants VALUES("39","83","16","2","S/Green-9999","0","0","0","","");
INSERT INTO product_variants VALUES("40","83","3","3","M/Red-9999","0","0","0","","");
INSERT INTO product_variants VALUES("41","83","17","4","M/Green-9999","0","0","0","","");
INSERT INTO product_variants VALUES("42","83","18","5","L/Red-9999","5","10","0","","");
INSERT INTO product_variants VALUES("43","83","19","6","L/Green-9999","5","10","0","","");
INSERT INTO product_variants VALUES("44","87","1","1","S/Red-9999","0","0","0","","");
INSERT INTO product_variants VALUES("45","87","16","2","S/Green-9999","0","0","0","","");
INSERT INTO product_variants VALUES("46","87","3","3","M/Red-9999","0","0","0","","");
INSERT INTO product_variants VALUES("47","87","17","4","M/Green-9999","0","0","0","","");
INSERT INTO product_variants VALUES("48","87","18","5","L/Red-9999","5","10","0","","");
INSERT INTO product_variants VALUES("49","87","19","6","L/Green-9999","5","10","0","","");



CREATE TABLE `product_warehouse` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `product_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_batch_id` int DEFAULT NULL,
  `variant_id` int DEFAULT NULL,
  `imei_number` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `warehouse_id` int NOT NULL,
  `qty` double NOT NULL,
  `price` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=240 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO product_warehouse VALUES("1","23","","","","1","-6","577","2024-01-19 19:46:04","2025-01-12 12:19:56");
INSERT INTO product_warehouse VALUES("2","27","","","","1","8","1.29","2024-01-19 19:46:04","2025-01-12 12:19:04");
INSERT INTO product_warehouse VALUES("3","20","","","","1","-6","499","2024-01-19 19:46:04","2024-11-27 17:51:28");
INSERT INTO product_warehouse VALUES("4","17","","","","1","-4","499","2024-01-19 19:46:04","2024-11-27 17:51:28");
INSERT INTO product_warehouse VALUES("5","16","","","","1","10","109","2024-01-19 19:46:04","2024-07-11 12:31:01");
INSERT INTO product_warehouse VALUES("6","30","","","","1","10","200","2024-01-19 19:46:04","2024-01-19 19:46:04");
INSERT INTO product_warehouse VALUES("7","19","","","","1","9","1059","2024-01-19 19:46:04","2024-05-28 14:46:50");
INSERT INTO product_warehouse VALUES("8","3","","","","1","6","350","2024-01-19 19:46:05","2025-01-08 12:39:27");
INSERT INTO product_warehouse VALUES("9","7","","","","1","23","","2024-01-19 19:46:05","2025-01-08 12:59:11");
INSERT INTO product_warehouse VALUES("10","2","","","","1","2","","2024-01-19 19:46:05","2024-08-11 11:48:52");
INSERT INTO product_warehouse VALUES("11","6","","","null,null","1","10","1111.99","2024-01-19 19:50:04","2025-01-26 22:41:40");
INSERT INTO product_warehouse VALUES("12","13","","","","1","10","349","2024-01-19 19:50:04","2024-01-19 19:50:04");
INSERT INTO product_warehouse VALUES("13","10","","","","1","10","1250","2024-01-19 19:50:04","2024-01-19 19:50:04");
INSERT INTO product_warehouse VALUES("14","21","","","","1","10","599","2024-01-19 19:50:04","2024-01-19 19:50:04");
INSERT INTO product_warehouse VALUES("15","8","","","","1","8","1300","2024-01-19 19:50:04","2024-05-19 14:30:55");
INSERT INTO product_warehouse VALUES("16","12","","","","1","10","1250","2024-01-19 19:50:04","2024-01-19 19:50:04");
INSERT INTO product_warehouse VALUES("17","29","","","","1","10","3.19","2024-01-19 19:50:04","2024-01-19 19:50:04");
INSERT INTO product_warehouse VALUES("18","26","","","","1","15","3.99","2024-01-19 19:50:04","2025-01-08 12:59:11");
INSERT INTO product_warehouse VALUES("19","9","","","","1","10","559","2024-01-19 19:50:04","2024-01-19 19:50:04");
INSERT INTO product_warehouse VALUES("20","11","","","","1","10","1750","2024-01-19 19:50:04","2024-01-19 19:50:04");
INSERT INTO product_warehouse VALUES("21","1","","","","1","-19","1299.99","2024-01-19 19:53:21","2025-01-01 14:37:52");
INSERT INTO product_warehouse VALUES("22","18","","","","1","10","599","2024-01-19 19:53:21","2024-01-19 19:53:21");
INSERT INTO product_warehouse VALUES("23","25","","","","1","10","157.99","2024-01-19 19:53:21","2024-01-19 19:53:21");
INSERT INTO product_warehouse VALUES("24","28","","","","1","10","3.3","2024-01-19 19:53:21","2024-01-19 19:53:21");
INSERT INTO product_warehouse VALUES("25","14","","","","1","9","499","2024-01-19 19:53:21","2024-01-19 20:40:16");
INSERT INTO product_warehouse VALUES("26","24","","","","1","10","379","2024-01-19 19:53:21","2024-01-19 19:53:21");
INSERT INTO product_warehouse VALUES("27","4","","","","1","-31","1050","2024-01-19 19:53:21","2024-12-29 12:40:02");
INSERT INTO product_warehouse VALUES("28","5","","","","1","10","1150.99","2024-01-19 19:53:21","2024-08-26 05:29:53");
INSERT INTO product_warehouse VALUES("29","22","","","","1","10","399","2024-01-19 19:53:21","2024-01-19 19:53:21");
INSERT INTO product_warehouse VALUES("30","15","","","","1","10","547","2024-01-19 19:53:21","2024-01-19 19:53:21");
INSERT INTO product_warehouse VALUES("31","1","","","","2","11","1299.99","2024-01-19 20:26:48","2024-01-19 20:26:48");
INSERT INTO product_warehouse VALUES("32","18","","","","2","7","599","2024-01-19 20:26:48","2024-08-11 11:37:38");
INSERT INTO product_warehouse VALUES("33","25","","","","2","10","157.99","2024-01-19 20:26:48","2024-01-19 20:26:48");
INSERT INTO product_warehouse VALUES("34","28","","","","2","10","3.3","2024-01-19 20:26:48","2024-01-19 20:26:48");
INSERT INTO product_warehouse VALUES("35","14","","","","2","10","499","2024-01-19 20:26:49","2024-01-19 20:26:49");
INSERT INTO product_warehouse VALUES("36","24","","","","2","10","379","2024-01-19 20:26:49","2024-01-19 20:26:49");
INSERT INTO product_warehouse VALUES("37","4","","","","2","9","1050","2024-01-19 20:26:49","2024-01-19 20:44:41");
INSERT INTO product_warehouse VALUES("38","5","","","","2","10","1150.99","2024-01-19 20:26:49","2024-01-19 20:26:49");
INSERT INTO product_warehouse VALUES("39","22","","","","2","10","399","2024-01-19 20:26:49","2024-01-19 20:26:49");
INSERT INTO product_warehouse VALUES("40","15","","","","2","10","547","2024-01-19 20:26:49","2024-01-19 20:26:49");
INSERT INTO product_warehouse VALUES("41","23","","","","2","10","577","2024-01-19 20:28:26","2024-05-28 15:05:50");
INSERT INTO product_warehouse VALUES("42","27","","","","2","7","1.29","2024-01-19 20:28:26","2024-01-19 20:48:33");
INSERT INTO product_warehouse VALUES("43","20","","","","2","11","499","2024-01-19 20:28:26","2024-05-28 15:07:14");
INSERT INTO product_warehouse VALUES("44","17","","","","2","10","499","2024-01-19 20:28:26","2024-01-19 20:28:26");
INSERT INTO product_warehouse VALUES("45","16","","","","2","9","109","2024-01-19 20:28:26","2024-01-19 20:44:41");
INSERT INTO product_warehouse VALUES("46","30","","","","2","10","200","2024-01-19 20:28:26","2024-01-19 20:28:26");
INSERT INTO product_warehouse VALUES("47","19","","","","2","10","1059","2024-01-19 20:28:26","2024-05-28 14:46:50");
INSERT INTO product_warehouse VALUES("48","3","","","","2","8","350","2024-01-19 20:28:26","2024-01-19 20:44:41");
INSERT INTO product_warehouse VALUES("49","7","","","","2","10","","2024-01-19 20:28:26","2024-05-23 13:38:12");
INSERT INTO product_warehouse VALUES("50","2","","","","2","10","","2024-01-19 20:28:26","2024-03-07 13:13:42");
INSERT INTO product_warehouse VALUES("51","6","","","","2","10","1111.99","2024-01-19 20:28:35","2024-01-19 20:28:35");
INSERT INTO product_warehouse VALUES("52","13","","","","2","10","349","2024-01-19 20:28:35","2024-01-19 20:28:35");
INSERT INTO product_warehouse VALUES("53","10","","","","2","10","1250","2024-01-19 20:28:35","2024-01-19 20:28:35");
INSERT INTO product_warehouse VALUES("54","21","","","","2","10","599","2024-01-19 20:28:35","2024-01-19 20:28:35");
INSERT INTO product_warehouse VALUES("55","8","","","","2","10","1300","2024-01-19 20:28:35","2024-01-19 20:28:35");
INSERT INTO product_warehouse VALUES("56","12","","","","2","10","1250","2024-01-19 20:28:35","2024-01-19 20:28:35");
INSERT INTO product_warehouse VALUES("57","29","","","","2","10","3.19","2024-01-19 20:28:35","2024-01-19 20:28:35");
INSERT INTO product_warehouse VALUES("58","26","","","","2","10","3.99","2024-01-19 20:28:35","2024-01-19 20:28:35");
INSERT INTO product_warehouse VALUES("59","9","","","","2","9","559","2024-01-19 20:28:35","2024-01-19 20:44:41");
INSERT INTO product_warehouse VALUES("60","11","","","","2","10","1750","2024-01-19 20:28:35","2024-01-19 20:28:35");
INSERT INTO product_warehouse VALUES("61","32","","","","1","0","","2024-04-29 18:29:17","2024-04-29 18:29:17");
INSERT INTO product_warehouse VALUES("62","32","","","","2","0","","2024-04-29 18:29:17","2024-04-29 18:29:17");
INSERT INTO product_warehouse VALUES("63","33","","","1002,1004,1005","1","3","","2024-07-18 13:39:33","2024-11-24 16:47:26");
INSERT INTO product_warehouse VALUES("64","33","","","2002,2003,2004,2005,","2","4","","2024-07-18 13:39:33","2024-07-18 14:01:45");
INSERT INTO product_warehouse VALUES("65","34","","1","","1","0","","2024-11-24 14:57:18","2024-11-24 14:57:18");
INSERT INTO product_warehouse VALUES("66","34","","2","","1","7","","2024-11-24 14:57:18","2024-11-24 16:44:05");
INSERT INTO product_warehouse VALUES("67","34","","3","","1","0","","2024-11-24 14:57:18","2024-11-24 14:57:18");
INSERT INTO product_warehouse VALUES("68","34","","4","","1","0","","2024-11-24 14:57:18","2024-11-24 14:57:18");
INSERT INTO product_warehouse VALUES("69","34","","1","","2","0","","2024-11-24 14:57:18","2024-11-24 14:57:18");
INSERT INTO product_warehouse VALUES("70","34","","2","null","2","1","","2024-11-24 14:57:18","2024-11-24 15:11:28");
INSERT INTO product_warehouse VALUES("71","34","","3","","2","0","","2024-11-24 14:57:18","2024-11-24 14:57:18");
INSERT INTO product_warehouse VALUES("72","34","","4","","2","0","","2024-11-24 14:57:18","2024-11-24 14:57:18");
INSERT INTO product_warehouse VALUES("73","35","","","","1","10","","2024-12-02 14:44:02","2024-12-02 14:44:02");
INSERT INTO product_warehouse VALUES("74","35","","","","2","47","","2024-12-02 14:44:02","2024-12-02 14:44:02");
INSERT INTO product_warehouse VALUES("75","36","","5","","1","1","","2024-12-19 11:23:34","2024-12-19 15:32:43");
INSERT INTO product_warehouse VALUES("76","36","","6","","1","0","","2024-12-19 11:23:34","2024-12-19 11:23:34");
INSERT INTO product_warehouse VALUES("77","36","","7","","1","0","","2024-12-19 11:23:34","2024-12-19 11:23:34");
INSERT INTO product_warehouse VALUES("78","36","","5","","2","0","","2024-12-19 11:23:34","2024-12-19 11:23:34");
INSERT INTO product_warehouse VALUES("79","36","","6","","2","0","","2024-12-19 11:23:34","2024-12-19 11:23:34");
INSERT INTO product_warehouse VALUES("80","36","","7","","2","0","","2024-12-19 11:23:34","2024-12-19 11:23:34");
INSERT INTO product_warehouse VALUES("81","37","","5","","1","1","","2024-12-19 11:25:08","2024-12-19 15:32:43");
INSERT INTO product_warehouse VALUES("82","37","","6","","1","0","","2024-12-19 11:25:08","2024-12-19 11:25:08");
INSERT INTO product_warehouse VALUES("83","37","","7","","1","0","","2024-12-19 11:25:08","2024-12-19 11:25:08");
INSERT INTO product_warehouse VALUES("84","37","","5","","2","0","","2024-12-19 11:25:08","2024-12-19 11:25:08");
INSERT INTO product_warehouse VALUES("85","37","","6","","2","0","","2024-12-19 11:25:08","2024-12-19 11:25:08");
INSERT INTO product_warehouse VALUES("86","37","","7","","2","0","","2024-12-19 11:25:08","2024-12-19 11:25:08");
INSERT INTO product_warehouse VALUES("87","38","","5","","1","1","","2024-12-19 11:26:10","2024-12-19 15:32:43");
INSERT INTO product_warehouse VALUES("88","38","","6","","1","0","","2024-12-19 11:26:10","2024-12-19 11:26:10");
INSERT INTO product_warehouse VALUES("89","38","","7","","1","0","","2024-12-19 11:26:10","2024-12-19 11:26:10");
INSERT INTO product_warehouse VALUES("90","38","","5","","2","0","","2024-12-19 11:26:10","2024-12-19 11:26:10");
INSERT INTO product_warehouse VALUES("91","38","","6","","2","0","","2024-12-19 11:26:10","2024-12-19 11:26:10");
INSERT INTO product_warehouse VALUES("92","38","","7","","2","0","","2024-12-19 11:26:10","2024-12-19 11:26:10");
INSERT INTO product_warehouse VALUES("93","39","","","","1","1","","2024-12-19 11:29:19","2024-12-19 15:32:43");
INSERT INTO product_warehouse VALUES("94","39","","","","2","0","","2024-12-19 11:29:19","2024-12-19 11:29:19");
INSERT INTO product_warehouse VALUES("95","40","","","","1","10","","2024-12-19 11:39:16","2024-12-19 11:40:33");
INSERT INTO product_warehouse VALUES("96","40","","","","2","0","","2024-12-19 11:39:16","2024-12-19 11:39:16");
INSERT INTO product_warehouse VALUES("97","41","","","","1","10","","2024-12-19 11:39:49","2024-12-19 11:40:33");
INSERT INTO product_warehouse VALUES("98","41","","","","2","0","","2024-12-19 11:39:49","2024-12-19 11:39:49");
INSERT INTO product_warehouse VALUES("99","42","","","","1","-1","","2024-12-19 11:42:27","2024-12-19 11:43:03");
INSERT INTO product_warehouse VALUES("100","42","","","","2","0","","2024-12-19 11:42:27","2024-12-19 11:42:27");
INSERT INTO product_warehouse VALUES("101","43","","","","1","0","","2025-01-08 11:24:23","2025-01-08 11:24:23");
INSERT INTO product_warehouse VALUES("102","43","","","","2","0","","2025-01-08 11:24:23","2025-01-08 11:24:23");
INSERT INTO product_warehouse VALUES("103","31","","","","1","5","","2025-01-08 12:59:11","2025-01-08 12:59:11");
INSERT INTO product_warehouse VALUES("104","44","","","","1","10","","2025-01-08 14:41:42","2025-01-08 14:41:42");
INSERT INTO product_warehouse VALUES("105","45","","8","","1","0","100","2025-01-08 14:45:23","2025-01-08 18:48:13");
INSERT INTO product_warehouse VALUES("106","46","","","","1","0","","2025-01-08 14:53:30","2025-01-08 18:48:02");
INSERT INTO product_warehouse VALUES("107","46","","","","2","0","","2025-01-08 14:53:30","2025-01-08 14:53:30");
INSERT INTO product_warehouse VALUES("108","47","","5","","1","0","","2025-01-08 15:08:46","2025-01-08 18:47:51");
INSERT INTO product_warehouse VALUES("109","47","","7","","1","0","","2025-01-08 15:08:46","2025-01-08 15:08:46");
INSERT INTO product_warehouse VALUES("110","47","","9","","1","0","","2025-01-08 15:08:46","2025-01-08 15:08:46");
INSERT INTO product_warehouse VALUES("111","47","","5","","2","0","","2025-01-08 15:08:46","2025-01-08 15:08:46");
INSERT INTO product_warehouse VALUES("112","47","","7","","2","0","","2025-01-08 15:08:46","2025-01-08 15:08:46");
INSERT INTO product_warehouse VALUES("113","47","","9","","2","0","","2025-01-08 15:08:46","2025-01-08 15:08:46");
INSERT INTO product_warehouse VALUES("114","48","","10","silver01,silver02","1","2","","2025-01-08 18:50:34","2025-01-08 18:51:26");
INSERT INTO product_warehouse VALUES("115","48","","11","","1","0","","2025-01-08 18:50:34","2025-01-12 12:09:39");
INSERT INTO product_warehouse VALUES("116","48","","10","","2","0","","2025-01-08 18:50:34","2025-01-08 18:50:34");
INSERT INTO product_warehouse VALUES("117","48","","11","","2","0","","2025-01-08 18:50:34","2025-01-08 18:50:34");
INSERT INTO product_warehouse VALUES("118","49","","12","","1","0","","2025-01-08 18:56:54","2025-01-12 12:09:30");
INSERT INTO product_warehouse VALUES("119","49","","13","","1","0","","2025-01-08 18:56:54","2025-01-11 09:25:35");
INSERT INTO product_warehouse VALUES("120","49","","12","","2","0","","2025-01-08 18:56:54","2025-01-08 18:56:54");
INSERT INTO product_warehouse VALUES("121","49","","13","","2","0","","2025-01-08 18:56:54","2025-01-08 18:56:54");
INSERT INTO product_warehouse VALUES("122","50","","11","","1","0","100","2025-01-09 10:33:34","2025-01-12 12:09:24");
INSERT INTO product_warehouse VALUES("123","50","","14","","1","0","100","2025-01-09 11:22:07","2025-01-11 10:13:43");
INSERT INTO product_warehouse VALUES("124","51","","","","1","-1","","2025-01-09 11:25:59","2025-01-11 09:25:10");
INSERT INTO product_warehouse VALUES("125","51","","","","2","0","","2025-01-09 11:25:59","2025-01-09 11:25:59");
INSERT INTO product_warehouse VALUES("126","52","","","","1","0","","2025-01-11 15:08:35","2025-01-12 12:09:18");
INSERT INTO product_warehouse VALUES("127","52","","","","2","0","","2025-01-11 15:08:35","2025-01-11 15:08:35");
INSERT INTO product_warehouse VALUES("128","53","","","null,null","1","-5","","2025-01-12 12:21:51","2025-01-15 10:01:32");
INSERT INTO product_warehouse VALUES("129","53","","","","2","0","","2025-01-12 12:21:51","2025-01-12 12:21:51");
INSERT INTO product_warehouse VALUES("130","54","","","","1","10","","2025-01-12 13:19:24","2025-01-12 13:40:34");
INSERT INTO product_warehouse VALUES("131","54","","","","2","10","","2025-01-12 13:19:24","2025-01-12 13:19:24");
INSERT INTO product_warehouse VALUES("132","55","","5","dd1,dd21,dd7","1","1","","2025-01-12 13:22:24","2025-01-21 14:17:16");
INSERT INTO product_warehouse VALUES("133","55","","11","dd3,dd4,dd9,aa1","1","0","100","2025-01-12 13:53:23","2025-01-19 17:11:38");
INSERT INTO product_warehouse VALUES("134","56","","","","1","-2","","2025-01-14 14:05:08","2025-01-15 11:42:39");
INSERT INTO product_warehouse VALUES("135","56","","","","2","0","","2025-01-14 14:05:08","2025-01-14 14:05:08");
INSERT INTO product_warehouse VALUES("136","57","","","","1","0","","2025-01-14 17:02:00","2025-01-14 17:02:00");
INSERT INTO product_warehouse VALUES("137","57","","","","2","0","","2025-01-14 17:02:00","2025-01-14 17:02:00");
INSERT INTO product_warehouse VALUES("138","58","","","null,null","1","0","","2025-01-14 17:05:19","2025-01-14 17:32:25");
INSERT INTO product_warehouse VALUES("139","58","","","","2","0","","2025-01-14 17:05:19","2025-01-14 17:05:19");
INSERT INTO product_warehouse VALUES("140","59","","","","1","-2","","2025-01-15 11:43:13","2025-01-15 14:22:28");
INSERT INTO product_warehouse VALUES("141","59","","","","2","0","","2025-01-15 11:43:13","2025-01-15 11:43:13");
INSERT INTO product_warehouse VALUES("142","60","","","Stock is empty,ee1,ee1,ee2","1","0","","2025-01-15 14:23:25","2025-01-15 15:29:05");
INSERT INTO product_warehouse VALUES("143","60","","","","2","0","","2025-01-15 14:23:25","2025-01-15 14:23:25");
INSERT INTO product_warehouse VALUES("144","61","","","ee1","1","0","","2025-01-15 14:36:54","2025-01-15 15:54:59");
INSERT INTO product_warehouse VALUES("145","61","","","","2","0","","2025-01-15 14:36:54","2025-01-15 14:36:54");
INSERT INTO product_warehouse VALUES("146","62","","","","1","-2","10","2025-01-15 15:56:06","2025-01-16 12:09:02");
INSERT INTO product_warehouse VALUES("147","62","","","","2","0","10","2025-01-15 15:56:06","2025-01-16 12:08:56");
INSERT INTO product_warehouse VALUES("148","63","","11","b-456,b-455","1","2","","2025-01-17 00:28:46","2025-01-17 00:30:53");
INSERT INTO product_warehouse VALUES("149","63","","10","sl-456,sl-455","1","2","","2025-01-17 00:28:46","2025-01-17 00:30:53");
INSERT INTO product_warehouse VALUES("150","63","","11","","2","0","","2025-01-17 00:28:46","2025-01-17 00:28:46");
INSERT INTO product_warehouse VALUES("151","63","","10","","2","0","","2025-01-17 00:28:46","2025-01-17 00:28:46");
INSERT INTO product_warehouse VALUES("152","64","","","bb1","1","1","","2025-01-19 17:17:44","2025-01-19 17:18:31");
INSERT INTO product_warehouse VALUES("153","64","","","","2","0","","2025-01-19 17:17:44","2025-01-19 17:17:44");
INSERT INTO product_warehouse VALUES("154","65","","","","1","0","","2025-01-20 10:04:48","2025-01-20 10:04:48");
INSERT INTO product_warehouse VALUES("155","65","","","","2","0","","2025-01-20 10:04:48","2025-01-20 10:04:48");
INSERT INTO product_warehouse VALUES("156","66","","","","1","0","","2025-01-20 10:29:49","2025-01-20 10:29:49");
INSERT INTO product_warehouse VALUES("157","66","","","","2","0","","2025-01-20 10:29:49","2025-01-20 10:29:49");
INSERT INTO product_warehouse VALUES("158","67","","","","1","0","","2025-01-20 10:32:24","2025-01-20 10:32:24");
INSERT INTO product_warehouse VALUES("159","67","","","","2","0","","2025-01-20 10:32:24","2025-01-20 10:32:24");
INSERT INTO product_warehouse VALUES("160","68","","","","1","0","","2025-01-20 10:34:42","2025-01-20 10:34:42");
INSERT INTO product_warehouse VALUES("161","68","","","","2","0","","2025-01-20 10:34:42","2025-01-20 10:34:42");
INSERT INTO product_warehouse VALUES("162","69","","","","1","0","","2025-01-20 10:46:55","2025-01-20 10:46:55");
INSERT INTO product_warehouse VALUES("163","69","","","","2","0","","2025-01-20 10:46:55","2025-01-20 10:46:55");
INSERT INTO product_warehouse VALUES("164","70","","15","moneybag1","1","0","","2025-01-20 10:53:13","2025-01-20 12:16:31");
INSERT INTO product_warehouse VALUES("165","70","","11","","1","0","","2025-01-20 10:53:13","2025-01-20 10:53:13");
INSERT INTO product_warehouse VALUES("166","70","","15","","2","0","","2025-01-20 10:53:13","2025-01-20 10:53:13");
INSERT INTO product_warehouse VALUES("167","70","","11","","2","0","","2025-01-20 10:53:13","2025-01-20 10:53:13");
INSERT INTO product_warehouse VALUES("168","71","","","null,null","1","0","","2025-01-20 11:21:54","2025-01-20 12:16:25");
INSERT INTO product_warehouse VALUES("169","71","","","","2","0","","2025-01-20 11:21:54","2025-01-20 11:21:54");
INSERT INTO product_warehouse VALUES("170","72","","","","1","0","","2025-01-20 14:29:55","2025-01-20 14:29:55");
INSERT INTO product_warehouse VALUES("171","72","","","","2","0","","2025-01-20 14:29:55","2025-01-20 14:29:55");
INSERT INTO product_warehouse VALUES("172","73","","","","1","0","","2025-01-20 14:37:31","2025-01-20 14:37:31");
INSERT INTO product_warehouse VALUES("173","73","","","","2","0","","2025-01-20 14:37:31","2025-01-20 14:37:31");
INSERT INTO product_warehouse VALUES("174","74","","","","1","0","","2025-01-20 14:48:16","2025-01-20 14:48:16");
INSERT INTO product_warehouse VALUES("175","74","","","","2","0","","2025-01-20 14:48:16","2025-01-20 14:48:16");
INSERT INTO product_warehouse VALUES("176","75","","","","1","0","","2025-01-20 14:49:49","2025-01-20 14:49:49");
INSERT INTO product_warehouse VALUES("177","75","","","","2","0","","2025-01-20 14:49:49","2025-01-20 14:49:49");
INSERT INTO product_warehouse VALUES("178","76","","","","1","0","","2025-01-20 15:05:56","2025-01-20 15:05:56");
INSERT INTO product_warehouse VALUES("179","76","","","","2","0","","2025-01-20 15:05:56","2025-01-20 15:05:56");
INSERT INTO product_warehouse VALUES("180","77","","","","1","0","","2025-01-20 15:34:03","2025-01-20 15:34:03");
INSERT INTO product_warehouse VALUES("181","77","","","","2","0","","2025-01-20 15:34:03","2025-01-20 15:34:03");
INSERT INTO product_warehouse VALUES("182","78","","","","1","0","","2025-01-20 17:36:11","2025-01-20 17:36:11");
INSERT INTO product_warehouse VALUES("183","78","","","","2","0","","2025-01-20 17:36:11","2025-01-20 17:36:11");
INSERT INTO product_warehouse VALUES("184","79","","","","1","-2","","2025-01-20 17:37:55","2025-01-21 14:17:16");
INSERT INTO product_warehouse VALUES("185","79","","","","2","0","","2025-01-20 17:37:55","2025-01-20 17:37:55");
INSERT INTO product_warehouse VALUES("186","80","","10","qq1,qq2,null","1","4","","2025-01-21 14:12:50","2025-01-22 11:42:18");
INSERT INTO product_warehouse VALUES("187","80","","5","qq3","1","1","","2025-01-21 14:12:50","2025-01-21 14:17:17");
INSERT INTO product_warehouse VALUES("188","80","","10","","2","0","","2025-01-21 14:12:50","2025-01-22 11:42:18");
INSERT INTO product_warehouse VALUES("189","80","","5","","2","0","","2025-01-21 14:12:50","2025-01-21 14:12:50");
INSERT INTO product_warehouse VALUES("190","81","","1","","1","0","","","");
INSERT INTO product_warehouse VALUES("191","81","","1","","2","0","","","");
INSERT INTO product_warehouse VALUES("192","81","","16","","1","0","","","");
INSERT INTO product_warehouse VALUES("193","81","","16","","2","0","","","");
INSERT INTO product_warehouse VALUES("194","81","","3","","1","0","","","");
INSERT INTO product_warehouse VALUES("195","81","","3","","2","0","","","");
INSERT INTO product_warehouse VALUES("196","81","","17","","1","0","","","");
INSERT INTO product_warehouse VALUES("197","81","","17","","2","0","","","");
INSERT INTO product_warehouse VALUES("198","81","","18","","1","0","","","");
INSERT INTO product_warehouse VALUES("199","81","","18","","2","0","","","");
INSERT INTO product_warehouse VALUES("200","81","","19","","1","0","","","");
INSERT INTO product_warehouse VALUES("201","81","","19","","2","0","","","");
INSERT INTO product_warehouse VALUES("202","82","","","","1","0","","","");
INSERT INTO product_warehouse VALUES("203","82","","","","2","0","","","");
INSERT INTO product_warehouse VALUES("204","83","","1","","1","0","","","");
INSERT INTO product_warehouse VALUES("205","83","","1","","2","0","","","");
INSERT INTO product_warehouse VALUES("206","83","","16","","1","0","","","");
INSERT INTO product_warehouse VALUES("207","83","","16","","2","0","","","");
INSERT INTO product_warehouse VALUES("208","83","","3","","1","0","","","");
INSERT INTO product_warehouse VALUES("209","83","","3","","2","0","","","");
INSERT INTO product_warehouse VALUES("210","83","","17","","1","0","","","");
INSERT INTO product_warehouse VALUES("211","83","","17","","2","0","","","");
INSERT INTO product_warehouse VALUES("212","83","","18","","1","0","","","");
INSERT INTO product_warehouse VALUES("213","83","","18","","2","0","","","");
INSERT INTO product_warehouse VALUES("214","83","","19","","1","0","","","");
INSERT INTO product_warehouse VALUES("215","83","","19","","2","0","","","");
INSERT INTO product_warehouse VALUES("216","84","","","","1","0","","","");
INSERT INTO product_warehouse VALUES("217","84","","","","2","0","","","");
INSERT INTO product_warehouse VALUES("218","85","","","","1","0","","2025-01-22 19:25:39","2025-01-22 19:25:39");
INSERT INTO product_warehouse VALUES("219","85","","","","2","0","","2025-01-22 19:25:39","2025-01-22 19:25:39");
INSERT INTO product_warehouse VALUES("220","86","","","","1","0","","2025-01-22 19:28:33","2025-01-22 19:28:33");
INSERT INTO product_warehouse VALUES("221","86","","","","2","0","","2025-01-22 19:28:33","2025-01-22 19:28:33");
INSERT INTO product_warehouse VALUES("222","87","","1","","1","0","","","");
INSERT INTO product_warehouse VALUES("223","87","","1","","2","0","","","");
INSERT INTO product_warehouse VALUES("224","87","","16","","1","0","","","");
INSERT INTO product_warehouse VALUES("225","87","","16","","2","0","","","");
INSERT INTO product_warehouse VALUES("226","87","","3","","1","0","","","");
INSERT INTO product_warehouse VALUES("227","87","","3","","2","0","","","");
INSERT INTO product_warehouse VALUES("228","87","","17","","1","0","","","");
INSERT INTO product_warehouse VALUES("229","87","","17","","2","0","","","");
INSERT INTO product_warehouse VALUES("230","87","","18","","1","0","","","");
INSERT INTO product_warehouse VALUES("231","87","","18","","2","0","","","");
INSERT INTO product_warehouse VALUES("232","87","","19","","1","0","","","");
INSERT INTO product_warehouse VALUES("233","87","","19","","2","0","","","");
INSERT INTO product_warehouse VALUES("234","88","","","","1","0","","","");
INSERT INTO product_warehouse VALUES("235","88","","","","2","0","","","");
INSERT INTO product_warehouse VALUES("236","89","","","","1","0","","2025-01-23 13:13:05","2025-01-23 13:13:05");
INSERT INTO product_warehouse VALUES("237","89","","","","2","0","","2025-01-23 13:13:05","2025-01-23 13:13:05");
INSERT INTO product_warehouse VALUES("238","90","","","","1","-1","","2025-01-25 17:18:39","2025-01-26 23:35:36");
INSERT INTO product_warehouse VALUES("239","90","","","","2","0","","2025-01-25 17:18:39","2025-01-25 17:18:39");



CREATE TABLE `productions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `warehouse_id` int NOT NULL,
  `user_id` int NOT NULL,
  `item` int NOT NULL,
  `total_qty` int NOT NULL,
  `total_tax` double NOT NULL,
  `total_cost` double NOT NULL,
  `shipping_cost` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `status` int NOT NULL,
  `document` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO productions VALUES("1","production-20241219-033243","1","1","1","2","0","900","0","900","1","","","2024-12-19 15:32:43","2024-12-19 15:32:43");



CREATE TABLE `products` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `barcode_symbology` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `brand_id` int DEFAULT NULL,
  `category_id` int NOT NULL,
  `unit_id` int NOT NULL,
  `purchase_unit_id` int NOT NULL,
  `sale_unit_id` int NOT NULL,
  `cost` double NOT NULL,
  `price` double NOT NULL,
  `wholesale_price` double DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `alert_quantity` double DEFAULT NULL,
  `daily_sale_objective` double DEFAULT NULL,
  `promotion` tinyint DEFAULT NULL,
  `promotion_price` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `starting_date` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_date` date DEFAULT NULL,
  `tax_id` int DEFAULT NULL,
  `tax_method` int DEFAULT NULL,
  `image` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `file` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_embeded` tinyint(1) DEFAULT NULL,
  `is_variant` tinyint(1) DEFAULT NULL,
  `is_batch` tinyint(1) DEFAULT NULL,
  `is_diffPrice` tinyint(1) DEFAULT NULL,
  `is_imei` tinyint(1) DEFAULT NULL,
  `featured` tinyint DEFAULT NULL,
  `product_list` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `variant_list` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qty_list` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price_list` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_details` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `variant_option` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `variant_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) DEFAULT NULL,
  `is_sync_disable` tinyint DEFAULT NULL,
  `woocommerce_product_id` int DEFAULT NULL,
  `woocommerce_media_id` int DEFAULT NULL,
  `guarantee` int DEFAULT NULL,
  `warranty` int DEFAULT NULL,
  `guarantee_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `warranty_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO products VALUES("1","Zenbook 14 OLED (UX3402)｜Laptops For Home – ASUS","59028109","standard","C128","2","6","1","1","1","1099.99","1299.99","","-8","","","1","1050.99","2024-01-08","","1","2","202401081146401.png","","","","","","","1","","","","","<p>Quisque varius diam vel metus mattis, id aliquam diam rhoncus. Proin vitae magna in dui finibus malesuada et at nulla. Morbi elit ex, viverra vitae ante vel, blandit feugiat ligula. Fusce fermentum iaculis nibh, at sodales leo maximus a. Nullam ultricies sodales nunc, in pellentesque lorem mattis quis. Cras imperdiet est in nunc tristique lacinia. Nullam aliquam mauris eu accumsan tincidunt. Suspendisse velit ex, aliquet vel ornare vel, dignissim a tortor.</p>
<p>Morbi ut sapien vitae odio accumsan gravida. Morbi vitae erat auctor, eleifend nunc a, lobortis neque. Praesent aliquam dignissim viverra. Maecenas lacus odio, feugiat eu nunc sit amet, maximus sagittis dolor. Vivamus nisi sapien, elementum sit amet eros sit amet, ultricies cursus ipsum. Sed consequat luctus ligula. Curabitur laoreet rhoncus blandit. Aenean vel diam ut arcu pharetra dignissim ut sed leo. Vivamus faucibus, ipsum in vestibulum vulputate, lorem orci convallis quam, sit amet consequat nulla felis pharetra lacus. Duis semper erat mauris, sed egestas purus commodo vel.</p>","","","1","","","","","","","","2024-01-08 11:46:42","2025-01-01 14:37:52");
INSERT INTO products VALUES("2","2021 Apple 12.9-inch iPad Pro Wi-Fi 512GB","2035892312345","standard","C128","3","6","1","1","1","1000","1100","1230","12","","","1","1200.00","2024-01-08","","1","2","202401081246041.png,202401081246062.png,202401081246063.png,202401081246064.png","","0","","","0","","1","","","","","<p>Quisque varius diam vel metus mattis, id aliquam diam rhoncus. Proin vitae magna in dui finibus malesuada et at nulla. Morbi elit ex, viverra vitae ante vel, blandit feugiat ligula. Fusce fermentum iaculis nibh, at sodales leo maximus a. Nullam ultricies sodales nunc, in pellentesque lorem mattis quis. Cras imperdiet est in nunc tristique lacinia. Nullam aliquam mauris eu accumsan tincidunt. Suspendisse velit ex, aliquet vel ornare vel, dignissim a tortor.</p>
<p>Morbi ut sapien vitae odio accumsan gravida. Morbi vitae erat auctor, eleifend nunc a, lobortis neque. Praesent aliquam dignissim viverra. Maecenas lacus odio, feugiat eu nunc sit amet, maximus sagittis dolor. Vivamus nisi sapien, elementum sit amet eros sit amet, ultricies cursus ipsum. Sed consequat luctus ligula. Curabitur laoreet rhoncus blandit. Aenean vel diam ut arcu pharetra dignissim ut sed leo. Vivamus faucibus, ipsum in vestibulum vulputate, lorem orci convallis quam, sit amet consequat nulla felis pharetra lacus. Duis semper erat mauris, sed egestas purus commodo vel.</p>","","","1","","","","","","","","2024-01-08 12:46:07","2025-01-01 14:47:11");
INSERT INTO products VALUES("3","Apple iPhone 11 (4GB-64GB) Black","49251814","standard","C128","1","1","1","1","1","300","350","","14","","","1","","2024-01-08","","1","2","202401081255081.png,202401081255112.png,202401081255123.png,202401081255134.png,202401081255135.png","","","","","","","1","","","","","<p>Quisque varius diam vel metus mattis, id aliquam diam rhoncus. Proin vitae magna in dui finibus malesuada et at nulla. Morbi elit ex, viverra vitae ante vel, blandit feugiat ligula. Fusce fermentum iaculis nibh, at sodales leo maximus a. Nullam ultricies sodales nunc, in pellentesque lorem mattis quis. Cras imperdiet est in nunc tristique lacinia. Nullam aliquam mauris eu accumsan tincidunt. Suspendisse velit ex, aliquet vel ornare vel, dignissim a tortor.</p>
<p>Morbi ut sapien vitae odio accumsan gravida. Morbi vitae erat auctor, eleifend nunc a, lobortis neque. Praesent aliquam dignissim viverra. Maecenas lacus odio, feugiat eu nunc sit amet, maximus sagittis dolor. Vivamus nisi sapien, elementum sit amet eros sit amet, ultricies cursus ipsum. Sed consequat luctus ligula. Curabitur laoreet rhoncus blandit. Aenean vel diam ut arcu pharetra dignissim ut sed leo. Vivamus faucibus, ipsum in vestibulum vulputate, lorem orci convallis quam, sit amet consequat nulla felis pharetra lacus. Duis semper erat mauris, sed egestas purus commodo vel.</p>","","","1","","","","","","","","2024-01-08 12:55:14","2025-01-08 12:39:27");
INSERT INTO products VALUES("4","Samsung Galaxy Chromebook Go, 14″ HD LED, Intel Celeron N4500","28090345","standard","C128","2","6","1","1","1","900","1050","","-22","","","","","","","1","2","202401080121221.png,202401080121242.png,202401080121243.png,202401080121254.png","","","","","","","1","","","","","<p>Quisque varius diam vel metus mattis, id aliquam diam rhoncus. Proin vitae magna in dui finibus malesuada et at nulla. Morbi elit ex, viverra vitae ante vel, blandit feugiat ligula. Fusce fermentum iaculis nibh, at sodales leo maximus a. Nullam ultricies sodales nunc, in pellentesque lorem mattis quis. Cras imperdiet est in nunc tristique lacinia. Nullam aliquam mauris eu accumsan tincidunt. Suspendisse velit ex, aliquet vel ornare vel, dignissim a tortor.</p>
<p>Morbi ut sapien vitae odio accumsan gravida. Morbi vitae erat auctor, eleifend nunc a, lobortis neque. Praesent aliquam dignissim viverra. Maecenas lacus odio, feugiat eu nunc sit amet, maximus sagittis dolor. Vivamus nisi sapien, elementum sit amet eros sit amet, ultricies cursus ipsum. Sed consequat luctus ligula. Curabitur laoreet rhoncus blandit. Aenean vel diam ut arcu pharetra dignissim ut sed leo. Vivamus faucibus, ipsum in vestibulum vulputate, lorem orci convallis quam, sit amet consequat nulla felis pharetra lacus. Duis semper erat mauris, sed egestas purus commodo vel.</p>","","","1","","","","","","","","2024-01-08 13:21:25","2024-12-29 12:40:02");
INSERT INTO products VALUES("5","SAMSUNG Galaxy Book Pro 15.6 Laptop – Intel Core i5","67015642","standard","C128","2","6","1","1","1","950.99","1150.99","","20","","","","","","","1","2","202401080124321.png,202401080124342.png,202401080124353.png","","","","","","","1","","","","","<p>Quisque varius diam vel metus mattis, id aliquam diam rhoncus. Proin vitae magna in dui finibus malesuada et at nulla. Morbi elit ex, viverra vitae ante vel, blandit feugiat ligula. Fusce fermentum iaculis nibh, at sodales leo maximus a. Nullam ultricies sodales nunc, in pellentesque lorem mattis quis. Cras imperdiet est in nunc tristique lacinia. Nullam aliquam mauris eu accumsan tincidunt. Suspendisse velit ex, aliquet vel ornare vel, dignissim a tortor.</p>
<p>Morbi ut sapien vitae odio accumsan gravida. Morbi vitae erat auctor, eleifend nunc a, lobortis neque. Praesent aliquam dignissim viverra. Maecenas lacus odio, feugiat eu nunc sit amet, maximus sagittis dolor. Vivamus nisi sapien, elementum sit amet eros sit amet, ultricies cursus ipsum. Sed consequat luctus ligula. Curabitur laoreet rhoncus blandit. Aenean vel diam ut arcu pharetra dignissim ut sed leo. Vivamus faucibus, ipsum in vestibulum vulputate, lorem orci convallis quam, sit amet consequat nulla felis pharetra lacus. Duis semper erat mauris, sed egestas purus commodo vel.</p>","","","1","","","","","","","","2024-01-08 13:24:36","2024-08-26 05:29:53");
INSERT INTO products VALUES("6","Microsoft – Surface Laptop 4 13.5” Touch-Screen – AMD Ryzen 5","24005329","standard","C128","3","6","1","1","1","999.99","1111.99","","20","","","","","","","","1","202401080127451.png,202401080127462.png,202401080127473.jpg,202401080127484.jpg,202401080127485.jpg","","","","","","","1","","","","","<p>Quisque varius diam vel metus mattis, id aliquam diam rhoncus. Proin vitae magna in dui finibus malesuada et at nulla. Morbi elit ex, viverra vitae ante vel, blandit feugiat ligula. Fusce fermentum iaculis nibh, at sodales leo maximus a. Nullam ultricies sodales nunc, in pellentesque lorem mattis quis. Cras imperdiet est in nunc tristique lacinia. Nullam aliquam mauris eu accumsan tincidunt. Suspendisse velit ex, aliquet vel ornare vel, dignissim a tortor.</p>
<p>Morbi ut sapien vitae odio accumsan gravida. Morbi vitae erat auctor, eleifend nunc a, lobortis neque. Praesent aliquam dignissim viverra. Maecenas lacus odio, feugiat eu nunc sit amet, maximus sagittis dolor. Vivamus nisi sapien, elementum sit amet eros sit amet, ultricies cursus ipsum. Sed consequat luctus ligula. Curabitur laoreet rhoncus blandit. Aenean vel diam ut arcu pharetra dignissim ut sed leo. Vivamus faucibus, ipsum in vestibulum vulputate, lorem orci convallis quam, sit amet consequat nulla felis pharetra lacus. Duis semper erat mauris, sed egestas purus commodo vel.</p>","","","1","","","","","","","","2024-01-08 13:27:49","2025-01-26 22:41:40");
INSERT INTO products VALUES("7","Acer Chromebook 315, 15.6 HD – Intel Celeron N4000","30798200","standard","C128","4","6","1","1","1","899.99","999.99","950","33","","","","","","","1","2","202401080130241.png,202401080130242.png,202401080130253.png","","0","","","0","","1","","","","","<p>Quisque varius diam vel metus mattis, id aliquam diam rhoncus. Proin vitae magna in dui finibus malesuada et at nulla. Morbi elit ex, viverra vitae ante vel, blandit feugiat ligula. Fusce fermentum iaculis nibh, at sodales leo maximus a. Nullam ultricies sodales nunc, in pellentesque lorem mattis quis. Cras imperdiet est in nunc tristique lacinia. Nullam aliquam mauris eu accumsan tincidunt. Suspendisse velit ex, aliquet vel ornare vel, dignissim a tortor.</p>
<p>Morbi ut sapien vitae odio accumsan gravida. Morbi vitae erat auctor, eleifend nunc a, lobortis neque. Praesent aliquam dignissim viverra. Maecenas lacus odio, feugiat eu nunc sit amet, maximus sagittis dolor. Vivamus nisi sapien, elementum sit amet eros sit amet, ultricies cursus ipsum. Sed consequat luctus ligula. Curabitur laoreet rhoncus blandit. Aenean vel diam ut arcu pharetra dignissim ut sed leo. Vivamus faucibus, ipsum in vestibulum vulputate, lorem orci convallis quam, sit amet consequat nulla felis pharetra lacus. Duis semper erat mauris, sed egestas purus commodo vel.</p>","","","1","","","","","","","","2024-01-08 13:30:25","2025-01-08 12:59:11");
INSERT INTO products VALUES("8","HP Victus 16-e00244AX GTX 1650 Gaming Laptop 16.1” FHD 144Hz","81526930","standard","C128","4","6","1","1","1","1199","1300","","18","","","","","","","1","2","202401080134061.png,202401080134072.png,202401080134073.png","","","","","","","1","","","","","<p>Quisque varius diam vel metus mattis, id aliquam diam rhoncus. Proin vitae magna in dui finibus malesuada et at nulla. Morbi elit ex, viverra vitae ante vel, blandit feugiat ligula. Fusce fermentum iaculis nibh, at sodales leo maximus a. Nullam ultricies sodales nunc, in pellentesque lorem mattis quis. Cras imperdiet est in nunc tristique lacinia. Nullam aliquam mauris eu accumsan tincidunt. Suspendisse velit ex, aliquet vel ornare vel, dignissim a tortor.</p>
<p>Morbi ut sapien vitae odio accumsan gravida. Morbi vitae erat auctor, eleifend nunc a, lobortis neque. Praesent aliquam dignissim viverra. Maecenas lacus odio, feugiat eu nunc sit amet, maximus sagittis dolor. Vivamus nisi sapien, elementum sit amet eros sit amet, ultricies cursus ipsum. Sed consequat luctus ligula. Curabitur laoreet rhoncus blandit. Aenean vel diam ut arcu pharetra dignissim ut sed leo. Vivamus faucibus, ipsum in vestibulum vulputate, lorem orci convallis quam, sit amet consequat nulla felis pharetra lacus. Duis semper erat mauris, sed egestas purus commodo vel.</p>","","","1","","","","","","","","2024-01-08 13:34:08","2024-05-19 14:30:55");
INSERT INTO products VALUES("9","Epson Inkjet WorkForce Pro WF-3820DWF","20142029","standard","C128","2","6","1","1","1","399","559","","19","","","","","","","","1","202401080141091.png,202401080141102.png,202401080141103.png","","","","","","","1","","","","","<p>Quisque varius diam vel metus mattis, id aliquam diam rhoncus. Proin vitae magna in dui finibus malesuada et at nulla. Morbi elit ex, viverra vitae ante vel, blandit feugiat ligula. Fusce fermentum iaculis nibh, at sodales leo maximus a. Nullam ultricies sodales nunc, in pellentesque lorem mattis quis. Cras imperdiet est in nunc tristique lacinia. Nullam aliquam mauris eu accumsan tincidunt. Suspendisse velit ex, aliquet vel ornare vel, dignissim a tortor.</p>
<p>Morbi ut sapien vitae odio accumsan gravida. Morbi vitae erat auctor, eleifend nunc a, lobortis neque. Praesent aliquam dignissim viverra. Maecenas lacus odio, feugiat eu nunc sit amet, maximus sagittis dolor. Vivamus nisi sapien, elementum sit amet eros sit amet, ultricies cursus ipsum. Sed consequat luctus ligula. Curabitur laoreet rhoncus blandit. Aenean vel diam ut arcu pharetra dignissim ut sed leo. Vivamus faucibus, ipsum in vestibulum vulputate, lorem orci convallis quam, sit amet consequat nulla felis pharetra lacus. Duis semper erat mauris, sed egestas purus commodo vel.</p>","","","1","","","","","","","","2024-01-08 13:41:11","2024-01-19 20:44:41");
INSERT INTO products VALUES("10","iPhone 14 Pro 256GB Gold","29733132","standard","C128","1","1","1","1","1","990","1250","","20","","","","","","","","1","202401080143591.png,202401080144002.png,202401080144013.png,202401080144014.png","","","","","","","1","","","","","<p>Quisque varius diam vel metus mattis, id aliquam diam rhoncus. Proin vitae magna in dui finibus malesuada et at nulla. Morbi elit ex, viverra vitae ante vel, blandit feugiat ligula. Fusce fermentum iaculis nibh, at sodales leo maximus a. Nullam ultricies sodales nunc, in pellentesque lorem mattis quis. Cras imperdiet est in nunc tristique lacinia. Nullam aliquam mauris eu accumsan tincidunt. Suspendisse velit ex, aliquet vel ornare vel, dignissim a tortor.</p>
<p>Morbi ut sapien vitae odio accumsan gravida. Morbi vitae erat auctor, eleifend nunc a, lobortis neque. Praesent aliquam dignissim viverra. Maecenas lacus odio, feugiat eu nunc sit amet, maximus sagittis dolor. Vivamus nisi sapien, elementum sit amet eros sit amet, ultricies cursus ipsum. Sed consequat luctus ligula. Curabitur laoreet rhoncus blandit. Aenean vel diam ut arcu pharetra dignissim ut sed leo. Vivamus faucibus, ipsum in vestibulum vulputate, lorem orci convallis quam, sit amet consequat nulla felis pharetra lacus. Duis semper erat mauris, sed egestas purus commodo vel.</p>","","","1","","","","","","","","2024-01-08 13:44:02","2024-01-19 20:28:35");
INSERT INTO products VALUES("11","Electrolux EW6F449ST PerfectCare 9 Kg Washing Machine","23279148","standard","C128","5","20","1","1","1","1500","1750","","20","","","1","1650","2024-01-13","","1","2","202401130329581.png,202401130330002.png,202401130330013.png","","","","","","","1","","","","","<p>Quisque varius diam vel metus mattis, id aliquam diam rhoncus. Proin vitae magna in dui finibus malesuada et at nulla. Morbi elit ex, viverra vitae ante vel, blandit feugiat ligula. Fusce fermentum iaculis nibh, at sodales leo maximus a. Nullam ultricies sodales nunc, in pellentesque lorem mattis quis. Cras imperdiet est in nunc tristique lacinia. Nullam aliquam mauris eu accumsan tincidunt. Suspendisse velit ex, aliquet vel ornare vel, dignissim a tortor.</p>
<p>Morbi ut sapien vitae odio accumsan gravida. Morbi vitae erat auctor, eleifend nunc a, lobortis neque. Praesent aliquam dignissim viverra. Maecenas lacus odio, feugiat eu nunc sit amet, maximus sagittis dolor. Vivamus nisi sapien, elementum sit amet eros sit amet, ultricies cursus ipsum. Sed consequat luctus ligula. Curabitur laoreet rhoncus blandit. Aenean vel diam ut arcu pharetra dignissim ut sed leo. Vivamus faucibus, ipsum in vestibulum vulputate, lorem orci convallis quam, sit amet consequat nulla felis pharetra lacus. Duis semper erat mauris, sed egestas purus commodo vel.</p>","","","1","","","","","","","","2024-01-13 15:30:02","2024-01-19 20:28:35");
INSERT INTO products VALUES("12","GORENJE Waschmaschine WHP74EPS Waschmaschine","43879312","standard","C128","2","20","1","1","1","999","1250","","20","","","","","","","1","2","202401130338301.png,202401130338322.png,202401130338323.png","","","","","","","1","","","","","<p>Quisque varius diam vel metus mattis, id aliquam diam rhoncus. Proin vitae magna in dui finibus malesuada et at nulla. Morbi elit ex, viverra vitae ante vel, blandit feugiat ligula. Fusce fermentum iaculis nibh, at sodales leo maximus a. Nullam ultricies sodales nunc, in pellentesque lorem mattis quis. Cras imperdiet est in nunc tristique lacinia. Nullam aliquam mauris eu accumsan tincidunt. Suspendisse velit ex, aliquet vel ornare vel, dignissim a tortor.</p>
<p>Morbi ut sapien vitae odio accumsan gravida. Morbi vitae erat auctor, eleifend nunc a, lobortis neque. Praesent aliquam dignissim viverra. Maecenas lacus odio, feugiat eu nunc sit amet, maximus sagittis dolor. Vivamus nisi sapien, elementum sit amet eros sit amet, ultricies cursus ipsum. Sed consequat luctus ligula. Curabitur laoreet rhoncus blandit. Aenean vel diam ut arcu pharetra dignissim ut sed leo. Vivamus faucibus, ipsum in vestibulum vulputate, lorem orci convallis quam, sit amet consequat nulla felis pharetra lacus. Duis semper erat mauris, sed egestas purus commodo vel.</p>","","","1","","","","","","","","2024-01-13 15:38:33","2024-01-19 20:28:35");
INSERT INTO products VALUES("13","iRobot Roomba E6 (6199) Robot Vacuum","56858702","standard","C128","4","22","1","1","1","250","349","","20","","","","","","","1","2","202401130343221.png","","","","","","","1","","","","","<p>Quisque varius diam vel metus mattis, id aliquam diam rhoncus. Proin vitae magna in dui finibus malesuada et at nulla. Morbi elit ex, viverra vitae ante vel, blandit feugiat ligula. Fusce fermentum iaculis nibh, at sodales leo maximus a. Nullam ultricies sodales nunc, in pellentesque lorem mattis quis. Cras imperdiet est in nunc tristique lacinia. Nullam aliquam mauris eu accumsan tincidunt. Suspendisse velit ex, aliquet vel ornare vel, dignissim a tortor.</p>
<p>Morbi ut sapien vitae odio accumsan gravida. Morbi vitae erat auctor, eleifend nunc a, lobortis neque. Praesent aliquam dignissim viverra. Maecenas lacus odio, feugiat eu nunc sit amet, maximus sagittis dolor. Vivamus nisi sapien, elementum sit amet eros sit amet, ultricies cursus ipsum. Sed consequat luctus ligula. Curabitur laoreet rhoncus blandit. Aenean vel diam ut arcu pharetra dignissim ut sed leo. Vivamus faucibus, ipsum in vestibulum vulputate, lorem orci convallis quam, sit amet consequat nulla felis pharetra lacus. Duis semper erat mauris, sed egestas purus commodo vel.</p>","","","1","","","","","","","","2024-01-13 15:43:24","2024-01-19 20:28:35");
INSERT INTO products VALUES("14","Sony Bravia 55X90J 4K Ultra HD 55″ 140 Screen Google Smart LED TV","16530612","standard","C128","3","23","1","1","1","350","499","","19","","","","","","","1","2","","","","","","","","1","","","","","<p>Quisque varius diam vel metus mattis, id aliquam diam rhoncus. Proin vitae magna in dui finibus malesuada et at nulla. Morbi elit ex, viverra vitae ante vel, blandit feugiat ligula. Fusce fermentum iaculis nibh, at sodales leo maximus a. Nullam ultricies sodales nunc, in pellentesque lorem mattis quis. Cras imperdiet est in nunc tristique lacinia. Nullam aliquam mauris eu accumsan tincidunt. Suspendisse velit ex, aliquet vel ornare vel, dignissim a tortor.</p>
<p>Morbi ut sapien vitae odio accumsan gravida. Morbi vitae erat auctor, eleifend nunc a, lobortis neque. Praesent aliquam dignissim viverra. Maecenas lacus odio, feugiat eu nunc sit amet, maximus sagittis dolor. Vivamus nisi sapien, elementum sit amet eros sit amet, ultricies cursus ipsum. Sed consequat luctus ligula. Curabitur laoreet rhoncus blandit. Aenean vel diam ut arcu pharetra dignissim ut sed leo. Vivamus faucibus, ipsum in vestibulum vulputate, lorem orci convallis quam, sit amet consequat nulla felis pharetra lacus. Duis semper erat mauris, sed egestas purus commodo vel.</p>","","","1","","","","","","","","2024-01-13 15:53:32","2024-01-19 20:40:16");
INSERT INTO products VALUES("15","Samsung 43AU7000 4K Ultra HD 43″ 109 Screen Smart LED TV","73189124","standard","C128","2","23","1","1","1","499","547","","20","","","","","","","","1","202401130357131.png,202401130357152.png,202401130357153.png","","","","","","","1","","","","","<p>Quisque varius diam vel metus mattis, id aliquam diam rhoncus. Proin vitae magna in dui finibus malesuada et at nulla. Morbi elit ex, viverra vitae ante vel, blandit feugiat ligula. Fusce fermentum iaculis nibh, at sodales leo maximus a. Nullam ultricies sodales nunc, in pellentesque lorem mattis quis. Cras imperdiet est in nunc tristique lacinia. Nullam aliquam mauris eu accumsan tincidunt. Suspendisse velit ex, aliquet vel ornare vel, dignissim a tortor.</p>
<p>Morbi ut sapien vitae odio accumsan gravida. Morbi vitae erat auctor, eleifend nunc a, lobortis neque. Praesent aliquam dignissim viverra. Maecenas lacus odio, feugiat eu nunc sit amet, maximus sagittis dolor. Vivamus nisi sapien, elementum sit amet eros sit amet, ultricies cursus ipsum. Sed consequat luctus ligula. Curabitur laoreet rhoncus blandit. Aenean vel diam ut arcu pharetra dignissim ut sed leo. Vivamus faucibus, ipsum in vestibulum vulputate, lorem orci convallis quam, sit amet consequat nulla felis pharetra lacus. Duis semper erat mauris, sed egestas purus commodo vel.</p>","","","1","","","","","","","","2024-01-13 15:57:16","2024-01-19 20:26:49");
INSERT INTO products VALUES("16","Apple TV HD 32GB (2nd Generation)","71493353","standard","C128","1","23","1","1","1","79","109","","19","","","","","","","","1","202401130401491.png,202401130401522.png,202401130401533.png,202401130401544.png","","","","","","","1","","","","","<p>Quisque varius diam vel metus mattis, id aliquam diam rhoncus. Proin vitae magna in dui finibus malesuada et at nulla. Morbi elit ex, viverra vitae ante vel, blandit feugiat ligula. Fusce fermentum iaculis nibh, at sodales leo maximus a. Nullam ultricies sodales nunc, in pellentesque lorem mattis quis. Cras imperdiet est in nunc tristique lacinia. Nullam aliquam mauris eu accumsan tincidunt. Suspendisse velit ex, aliquet vel ornare vel, dignissim a tortor.</p>
<p>Morbi ut sapien vitae odio accumsan gravida. Morbi vitae erat auctor, eleifend nunc a, lobortis neque. Praesent aliquam dignissim viverra. Maecenas lacus odio, feugiat eu nunc sit amet, maximus sagittis dolor. Vivamus nisi sapien, elementum sit amet eros sit amet, ultricies cursus ipsum. Sed consequat luctus ligula. Curabitur laoreet rhoncus blandit. Aenean vel diam ut arcu pharetra dignissim ut sed leo. Vivamus faucibus, ipsum in vestibulum vulputate, lorem orci convallis quam, sit amet consequat nulla felis pharetra lacus. Duis semper erat mauris, sed egestas purus commodo vel.</p>","","","1","","","","","","","","2024-01-13 16:01:55","2024-07-11 12:31:01");
INSERT INTO products VALUES("17","Apple Watch SE GPS + Cellular 40mm Space Gray","92178104","standard","C128","1","12","1","1","1","349","499","","6","","","","","","","","1","202401130410191.png,202401130410222.jpg,202401130410233.jpg","","0","","","0","","1","","","","","<p>Quisque varius diam vel metus mattis, id aliquam diam rhoncus. Proin vitae magna in dui finibus malesuada et at nulla. Morbi elit ex, viverra vitae ante vel, blandit feugiat ligula. Fusce fermentum iaculis nibh, at sodales leo maximus a. Nullam ultricies sodales nunc, in pellentesque lorem mattis quis. Cras imperdiet est in nunc tristique lacinia. Nullam aliquam mauris eu accumsan tincidunt. Suspendisse velit ex, aliquet vel ornare vel, dignissim a tortor.</p>
<p>Morbi ut sapien vitae odio accumsan gravida. Morbi vitae erat auctor, eleifend nunc a, lobortis neque. Praesent aliquam dignissim viverra. Maecenas lacus odio, feugiat eu nunc sit amet, maximus sagittis dolor. Vivamus nisi sapien, elementum sit amet eros sit amet, ultricies cursus ipsum. Sed consequat luctus ligula. Curabitur laoreet rhoncus blandit. Aenean vel diam ut arcu pharetra dignissim ut sed leo. Vivamus faucibus, ipsum in vestibulum vulputate, lorem orci convallis quam, sit amet consequat nulla felis pharetra lacus. Duis semper erat mauris, sed egestas purus commodo vel.</p>","","","1","","","","","","","","2024-01-13 16:10:24","2024-11-27 17:51:28");
INSERT INTO products VALUES("18","Xbox One Wireless Controller Black Color","93060790","standard","C128","","1","1","1","1","459","599","","17","","","","","","","1","2","202401150808421.jpg,202401150808432.jpg","","","","","","","1","","","","","<div class=@item-description@>
<p>Quisque varius diam vel metus mattis, id aliquam diam rhoncus. Proin vitae magna in dui finibus malesuada et at nulla. Morbi elit ex, viverra vitae ante vel, blandit feugiat ligula. Fusce fermentum iaculis nibh, at sodales leo maximus a. Nullam ultricies sodales nunc, in pellentesque lorem mattis quis. Cras imperdiet est in nunc tristique lacinia. Nullam aliquam mauris eu accumsan tincidunt. Suspendisse velit ex, aliquet vel ornare vel, dignissim a tortor.</p>
<p>Morbi ut sapien vitae odio accumsan gravida. Morbi vitae erat auctor, eleifend nunc a, lobortis neque. Praesent aliquam dignissim viverra. Maecenas lacus odio, feugiat eu nunc sit amet, maximus sagittis dolor. Vivamus nisi sapien, elementum sit amet eros sit amet, ultricies cursus ipsum. Sed consequat luctus ligula. Curabitur laoreet rhoncus blandit. Aenean vel diam ut arcu pharetra dignissim ut sed leo. Vivamus faucibus, ipsum in vestibulum vulputate, lorem orci convallis quam, sit amet consequat nulla felis pharetra lacus. Duis semper erat mauris, sed egestas purus commodo vel.</p>
</div>","","","1","","","","","","","","2024-01-15 20:08:43","2024-08-11 11:37:38");
INSERT INTO products VALUES("19","Apple iPhone XS Max-64GB -white","22061536","standard","C128","1","1","1","1","1","899","1059","","19","","","","","","","1","2","202401150814131.jpg","","","","","","","1","","","","","<div class=@item-description@>
<p>Quisque varius diam vel metus mattis, id aliquam diam rhoncus. Proin vitae magna in dui finibus malesuada et at nulla. Morbi elit ex, viverra vitae ante vel, blandit feugiat ligula. Fusce fermentum iaculis nibh, at sodales leo maximus a. Nullam ultricies sodales nunc, in pellentesque lorem mattis quis. Cras imperdiet est in nunc tristique lacinia. Nullam aliquam mauris eu accumsan tincidunt. Suspendisse velit ex, aliquet vel ornare vel, dignissim a tortor.</p>
<p>Morbi ut sapien vitae odio accumsan gravida. Morbi vitae erat auctor, eleifend nunc a, lobortis neque. Praesent aliquam dignissim viverra. Maecenas lacus odio, feugiat eu nunc sit amet, maximus sagittis dolor. Vivamus nisi sapien, elementum sit amet eros sit amet, ultricies cursus ipsum. Sed consequat luctus ligula. Curabitur laoreet rhoncus blandit. Aenean vel diam ut arcu pharetra dignissim ut sed leo. Vivamus faucibus, ipsum in vestibulum vulputate, lorem orci convallis quam, sit amet consequat nulla felis pharetra lacus. Duis semper erat mauris, sed egestas purus commodo vel.</p>
</div>","","","1","","","","","","","","2024-01-15 20:14:14","2024-04-28 12:15:44");
INSERT INTO products VALUES("20","Apple Watch Series 8 GPS 45mm Midnight Aluminum Case","31429623","standard","C128","1","12","1","1","1","399","499","","5","","","","","","","","1","202401151009571.png,202401151009582.png,202401151009583.jpg","","","","","","","1","","","","","<div class=@item-description@>
<p>Quisque varius diam vel metus mattis, id aliquam diam rhoncus. Proin vitae magna in dui finibus malesuada et at nulla. Morbi elit ex, viverra vitae ante vel, blandit feugiat ligula. Fusce fermentum iaculis nibh, at sodales leo maximus a. Nullam ultricies sodales nunc, in pellentesque lorem mattis quis. Cras imperdiet est in nunc tristique lacinia. Nullam aliquam mauris eu accumsan tincidunt. Suspendisse velit ex, aliquet vel ornare vel, dignissim a tortor.</p>
<p>Morbi ut sapien vitae odio accumsan gravida. Morbi vitae erat auctor, eleifend nunc a, lobortis neque. Praesent aliquam dignissim viverra. Maecenas lacus odio, feugiat eu nunc sit amet, maximus sagittis dolor. Vivamus nisi sapien, elementum sit amet eros sit amet, ultricies cursus ipsum. Sed consequat luctus ligula. Curabitur laoreet rhoncus blandit. Aenean vel diam ut arcu pharetra dignissim ut sed leo. Vivamus faucibus, ipsum in vestibulum vulputate, lorem orci convallis quam, sit amet consequat nulla felis pharetra lacus. Duis semper erat mauris, sed egestas purus commodo vel.</p>
</div>","","","1","","","","","","","","2024-01-15 22:09:59","2024-11-27 17:51:28");
INSERT INTO products VALUES("21","Huawei Watch GT 2 Sport Stainless Steel 46mm","02456392","standard","C128","3","12","1","1","1","369","599","","20","","","1","499","2024-01-15","","","1","202401151013061.png,202401151013062.png,202401151013073.png","","","","","","","1","","","","","<div class=@item-description@>
<p>Quisque varius diam vel metus mattis, id aliquam diam rhoncus. Proin vitae magna in dui finibus malesuada et at nulla. Morbi elit ex, viverra vitae ante vel, blandit feugiat ligula. Fusce fermentum iaculis nibh, at sodales leo maximus a. Nullam ultricies sodales nunc, in pellentesque lorem mattis quis. Cras imperdiet est in nunc tristique lacinia. Nullam aliquam mauris eu accumsan tincidunt. Suspendisse velit ex, aliquet vel ornare vel, dignissim a tortor.</p>
<p>Morbi ut sapien vitae odio accumsan gravida. Morbi vitae erat auctor, eleifend nunc a, lobortis neque. Praesent aliquam dignissim viverra. Maecenas lacus odio, feugiat eu nunc sit amet, maximus sagittis dolor. Vivamus nisi sapien, elementum sit amet eros sit amet, ultricies cursus ipsum. Sed consequat luctus ligula. Curabitur laoreet rhoncus blandit. Aenean vel diam ut arcu pharetra dignissim ut sed leo. Vivamus faucibus, ipsum in vestibulum vulputate, lorem orci convallis quam, sit amet consequat nulla felis pharetra lacus. Duis semper erat mauris, sed egestas purus commodo vel.</p>
</div>","","","1","","","","","","","","2024-01-15 22:13:07","2024-01-19 20:28:35");
INSERT INTO products VALUES("22","Samsung Galaxy Active 2 R835U Smartwatch 40mm","10203743","standard","C128","2","12","1","1","1","275","399","","20","","","","","","","","1","202401151019301.png,202401151019302.png,202401151019313.png","","","","","","","1","","","","","<div class=@item-description@>
<p>Quisque varius diam vel metus mattis, id aliquam diam rhoncus. Proin vitae magna in dui finibus malesuada et at nulla. Morbi elit ex, viverra vitae ante vel, blandit feugiat ligula. Fusce fermentum iaculis nibh, at sodales leo maximus a. Nullam ultricies sodales nunc, in pellentesque lorem mattis quis. Cras imperdiet est in nunc tristique lacinia. Nullam aliquam mauris eu accumsan tincidunt. Suspendisse velit ex, aliquet vel ornare vel, dignissim a tortor.</p>
<p>Morbi ut sapien vitae odio accumsan gravida. Morbi vitae erat auctor, eleifend nunc a, lobortis neque. Praesent aliquam dignissim viverra. Maecenas lacus odio, feugiat eu nunc sit amet, maximus sagittis dolor. Vivamus nisi sapien, elementum sit amet eros sit amet, ultricies cursus ipsum. Sed consequat luctus ligula. Curabitur laoreet rhoncus blandit. Aenean vel diam ut arcu pharetra dignissim ut sed leo. Vivamus faucibus, ipsum in vestibulum vulputate, lorem orci convallis quam, sit amet consequat nulla felis pharetra lacus. Duis semper erat mauris, sed egestas purus commodo vel.</p>
</div>","","","1","","","","","","","","2024-01-15 22:19:31","2024-01-19 20:26:49");
INSERT INTO products VALUES("23","Canon EOS R10 RF-S 18-45 IS STM","13929367","standard","C128","17","1","1","1","1","439","577","","4","","","","","","","","1","202401151024231.png,202401151024232.png,202401151024233.png","","","","","","","1","","","","","<div class=@item-description@>
<p>Quisque varius diam vel metus mattis, id aliquam diam rhoncus. Proin vitae magna in dui finibus malesuada et at nulla. Morbi elit ex, viverra vitae ante vel, blandit feugiat ligula. Fusce fermentum iaculis nibh, at sodales leo maximus a. Nullam ultricies sodales nunc, in pellentesque lorem mattis quis. Cras imperdiet est in nunc tristique lacinia. Nullam aliquam mauris eu accumsan tincidunt. Suspendisse velit ex, aliquet vel ornare vel, dignissim a tortor.</p>
<p>Morbi ut sapien vitae odio accumsan gravida. Morbi vitae erat auctor, eleifend nunc a, lobortis neque. Praesent aliquam dignissim viverra. Maecenas lacus odio, feugiat eu nunc sit amet, maximus sagittis dolor. Vivamus nisi sapien, elementum sit amet eros sit amet, ultricies cursus ipsum. Sed consequat luctus ligula. Curabitur laoreet rhoncus blandit. Aenean vel diam ut arcu pharetra dignissim ut sed leo. Vivamus faucibus, ipsum in vestibulum vulputate, lorem orci convallis quam, sit amet consequat nulla felis pharetra lacus. Duis semper erat mauris, sed egestas purus commodo vel.</p>
</div>","","","1","","","","","","","","2024-01-15 22:24:24","2025-01-12 12:19:56");
INSERT INTO products VALUES("24","Sony A7 III Mirrorless Camera Body Only","99421096","standard","C128","2","1","1","1","1","299","379","","20","","","","","","","1","2","202401151026581.png,202401151026592.png","","","","","","","1","","","","","<div class=@item-description@>
<p>Quisque varius diam vel metus mattis, id aliquam diam rhoncus. Proin vitae magna in dui finibus malesuada et at nulla. Morbi elit ex, viverra vitae ante vel, blandit feugiat ligula. Fusce fermentum iaculis nibh, at sodales leo maximus a. Nullam ultricies sodales nunc, in pellentesque lorem mattis quis. Cras imperdiet est in nunc tristique lacinia. Nullam aliquam mauris eu accumsan tincidunt. Suspendisse velit ex, aliquet vel ornare vel, dignissim a tortor.</p>
<p>Morbi ut sapien vitae odio accumsan gravida. Morbi vitae erat auctor, eleifend nunc a, lobortis neque. Praesent aliquam dignissim viverra. Maecenas lacus odio, feugiat eu nunc sit amet, maximus sagittis dolor. Vivamus nisi sapien, elementum sit amet eros sit amet, ultricies cursus ipsum. Sed consequat luctus ligula. Curabitur laoreet rhoncus blandit. Aenean vel diam ut arcu pharetra dignissim ut sed leo. Vivamus faucibus, ipsum in vestibulum vulputate, lorem orci convallis quam, sit amet consequat nulla felis pharetra lacus. Duis semper erat mauris, sed egestas purus commodo vel.</p>
</div>","","","1","","","","","","","","2024-01-15 22:27:00","2024-01-19 20:26:49");
INSERT INTO products VALUES("25","WOLFANG GA420 Action Camera 4K 60FPS 24MP","99218280","standard","C128","4","1","1","1","1","130","157.99","","20","","","","","","","","1","202401151029321.png,202401151029332.jpg,202401151029343.jpg","","","","","","","1","","","","","<div class=@item-description@>
<p>Quisque varius diam vel metus mattis, id aliquam diam rhoncus. Proin vitae magna in dui finibus malesuada et at nulla. Morbi elit ex, viverra vitae ante vel, blandit feugiat ligula. Fusce fermentum iaculis nibh, at sodales leo maximus a. Nullam ultricies sodales nunc, in pellentesque lorem mattis quis. Cras imperdiet est in nunc tristique lacinia. Nullam aliquam mauris eu accumsan tincidunt. Suspendisse velit ex, aliquet vel ornare vel, dignissim a tortor.</p>
<p>Morbi ut sapien vitae odio accumsan gravida. Morbi vitae erat auctor, eleifend nunc a, lobortis neque. Praesent aliquam dignissim viverra. Maecenas lacus odio, feugiat eu nunc sit amet, maximus sagittis dolor. Vivamus nisi sapien, elementum sit amet eros sit amet, ultricies cursus ipsum. Sed consequat luctus ligula. Curabitur laoreet rhoncus blandit. Aenean vel diam ut arcu pharetra dignissim ut sed leo. Vivamus faucibus, ipsum in vestibulum vulputate, lorem orci convallis quam, sit amet consequat nulla felis pharetra lacus. Duis semper erat mauris, sed egestas purus commodo vel.</p>
</div>","","","1","","","","","","","","2024-01-15 22:29:34","2024-01-19 20:26:48");
INSERT INTO products VALUES("26","Fresh Organic Navel Orange","33887520","standard","C128","","29","4","4","4","2.99","3.99","","25","","","","","","","","1","202401151115301.png","","","","","","","1","","","","","<p>Fresh Organic Navel Orange</p>","","","1","","","","","","","","2024-01-15 23:15:32","2025-01-08 12:59:11");
INSERT INTO products VALUES("27","Banana (pack of 12)","27583341","standard","C128","","29","1","1","1","0.89","1.29","","15","","","","","","","","1","202401151118271.png","","","","","","","1","","","","","","","","1","","","","","","","","2024-01-15 23:18:28","2025-01-12 12:19:04");
INSERT INTO products VALUES("28","Water Melon ~ 3KG","19186147","standard","C128","","29","1","1","1","2.39","3.3","","20","","","","","","","","1","202401151142511.png","","","","","","","1","","","","","<p>Water Melon ~ 3KG</p>","","","1","","","","","","","","2024-01-15 23:42:53","2024-01-19 20:26:48");
INSERT INTO products VALUES("29","Gala Original Apple - 1KG","80912386","standard","C128","","29","1","1","1","2.39","3.19","","20","","","","","","","","1","202401151144271.png","","","","","","","1","","","","","<p>Gala Original Apple - 1KG</p>","","","1","","","","","","","","2024-01-15 23:44:27","2024-01-19 20:28:35");
INSERT INTO products VALUES("30","Apple Smart Watch","12010761","standard","C128","1","12","1","1","1","100","200","","20","","","","","","","1","1","202401190429592.jpg","","0","","","0","","0","","","","","","","","1","","","","","","","","2024-01-19 15:43:44","2024-01-19 20:28:26");
INSERT INTO products VALUES("31","Alpha Cheese","33357221","standard","C128","","34","1","1","1","120","200","","5","","","","","","","","1","zummXD2dvAtI.png","","","","1","","","","","","","","","","","1","","","","","","","","2024-04-14 12:15:06","2025-01-08 12:59:11");
INSERT INTO products VALUES("32","green spice","61226895","standard","C128","19","40","1","1","1","10","20","","0","","","","","","","3","1","zummXD2dvAtI.png","","","","","","","","","","","","","","","1","","","","","","","","2024-04-29 18:29:17","2024-04-29 18:29:17");
INSERT INTO products VALUES("33","Samsung Adapter","99767039","standard","C128","2","6","1","1","1","100","250","","7","","","","","","","","1","zummXD2dvAtI.png","","","","","","1","","","","","","","","","1","","","","","","","","2024-07-18 13:39:33","2024-11-24 16:47:26");
INSERT INTO products VALUES("34","Test Varient","09759418","standard","C128","8","9","1","1","1","100","150","","8","","","","","","","","1","zummXD2dvAtI.png","","","1","","","","","","","","","","["Size","Color"]","["s,m","red,blue"]","1","","","","","","","","2024-11-24 14:57:18","2024-11-24 16:44:05");
INSERT INTO products VALUES("35","Embed","347130","standard","EAN8","6","40","1","1","1","87","617","0","57","0","20","","735","1980-10-16","2008-12-23","3","2","zummXD2dvAtI.png","","1","","","","","","","","","","<p>Sunt commodo minima .</p>","","","1","","","","","","","","2024-12-02 14:44:02","2024-12-02 14:44:02");
INSERT INTO products VALUES("36","Suite Case (Large)","51234109","standard","C128","19","17","1","1","1","150","300","300","1","","","","","","","","1","zummXD2dvAtI.png","","","1","","","","","","","","","","["color"]","["red,green,blue"]","1","","","","","","","","2024-12-19 11:23:34","2024-12-19 15:32:43");
INSERT INTO products VALUES("37","Suit Case (Medium)","97067049","standard","C128","19","17","1","1","1","150","300","300","1","","","","","","","","1","zummXD2dvAtI.png","","","1","","","","","","","","","","["color"]","["red,green,blue"]","1","","","","","","","","2024-12-19 11:25:08","2024-12-19 15:32:43");
INSERT INTO products VALUES("38","Suit Case (Small)","22307439","standard","C128","19","17","1","1","1","150","300","","1","","","","","","","","1","zummXD2dvAtI.png","","","1","","","","","","","","","","["color"]","["red,green,blue"]","1","","","","","","","","2024-12-19 11:26:10","2024-12-19 15:32:43");
INSERT INTO products VALUES("39","red combo","57106851","combo","C128","19","17","1","1","1","450","900","","1","","","","","","","","1","zummXD2dvAtI.png","","","","","","","","36,37,38","5,5,5","1,1,1","300,300,300","","","","1","","","","","","","","2024-12-19 11:29:19","2024-12-19 15:32:43");
INSERT INTO products VALUES("40","Banana","77895040","standard","C128","1","1","1","1","1","5","10","","10","","","","","","","","1","zummXD2dvAtI.png","","","","","","","","","","","","","","","1","","","","","","","","2024-12-19 11:39:16","2024-12-19 11:40:33");
INSERT INTO products VALUES("41","Apple","79571061","standard","C128","3","29","1","1","1","5","10","","10","","","","","","","","1","zummXD2dvAtI.png","","","","","","","","","","","","","","","1","","","","","","","","2024-12-19 11:39:49","2024-12-19 11:40:33");
INSERT INTO products VALUES("42","Custard","07363712","combo","C128","9","34","1","1","1","15","30","","-1","","","","","","","","1","zummXD2dvAtI.png","","","","","","","","41,40",",","1,2","10,10","","","","1","","","","","","","","2024-12-19 11:42:27","2024-12-19 11:43:03");
INSERT INTO products VALUES("43","sdf","18916709","standard","C128","1","1","1","1","1","100","100","","0","","","","","","","","1","zummXD2dvAtI.png","","","","","","","","","","","","","","","0","","","","","","","","2025-01-08 11:24:23","2025-01-08 11:25:32");
INSERT INTO products VALUES("44","Nokia Blue","89466095","standard","C128","20","42","1","1","1","10","100","","10","","","","","","","","1","zummXD2dvAtI.png","","","","","","","","","","","","","","","0","","","","","","","","2025-01-08 14:41:42","2025-01-08 14:42:09");
INSERT INTO products VALUES("45","Nokia Non Android","96392154","standard","C128","20","42","1","1","1","10","100","","0","","","","","","","","1","zummXD2dvAtI.png","","","1","","","1","","","","","","","["Color"]","["Black","Blue"]","0","","","","","","","","2025-01-08 14:43:52","2025-01-08 18:48:43");
INSERT INTO products VALUES("46","Product-Name","08462114","standard","C128","1","3","1","1","1","10","100","","0","","","","","","","","1","zummXD2dvAtI.png","","","","","","1","","","","","","","","","0","","","","","","","","2025-01-08 14:53:30","2025-01-08 18:49:11");
INSERT INTO products VALUES("53","Bob","52143189","standard","C128","3","1","1","1","1","10","100","","-5","","","","","","","","1","zummXD2dvAtI.png","","","","","","","","","","","","","","","1","","","","","","","","2025-01-12 12:21:51","2025-01-15 10:01:32");
INSERT INTO products VALUES("54","Abc","18759698","standard","C128","3","1","1","1","1","10","100","","20","","","","","","","2","1","zummXD2dvAtI.png","","0","","","0","1","0","","","","","","","","1","","","","","","","","2025-01-12 13:19:24","2025-01-25 12:49:26");
INSERT INTO products VALUES("55","Abd","27009213","standard","C128","2","1","1","1","1","10","101","","0","","","","","","","1","1","zummXD2dvAtI.png","","0","1","","0","1","0","","","","","","["Color"]","["Red,Black"]","1","","","","","","","","2025-01-12 13:20:38","2025-01-25 12:48:57");
INSERT INTO products VALUES("56","Abe","14890230","standard","C128","10","1","1","1","1","10","100","","-2","","","","","","","","1","zummXD2dvAtI.png","","","","","","1","","","","","","","","","0","","","","","","","","2025-01-14 14:05:08","2025-01-15 11:42:39");
INSERT INTO products VALUES("57","Ali","87143280","standard","C128","2","1","1","1","1","10","100","","0","","","","","","","","1","zummXD2dvAtI.png","","","","","","","","","","","","","","","0","","","","","","","","2025-01-14 17:01:59","2025-01-14 17:02:17");
INSERT INTO products VALUES("58","Alice","29619805","standard","C128","1","1","1","1","1","10","10","","0","","","","","","","","1","zummXD2dvAtI.png","","","","","","","","","","","","","","","0","","","","","","","","2025-01-14 17:05:18","2025-01-14 17:32:25");
INSERT INTO products VALUES("59","Abe","21381580","standard","C128","4","1","1","1","1","10","100","","-2","","","","","","","","1","zummXD2dvAtI.png","","","","","","1","","","","","","","","","0","","","","","","","","2025-01-15 11:43:12","2025-01-15 14:22:36");
INSERT INTO products VALUES("60","Abe","07298341","standard","C128","4","1","1","1","1","10","100","","0","","","","","","","","1","zummXD2dvAtI.png","","","","","","1","","","","","","","","","0","","","","","","","","2025-01-15 14:23:25","2025-01-15 15:29:05");
INSERT INTO products VALUES("61","Abe","71281253","standard","C128","4","1","1","1","1","10","100","","0","","","","","","","","1","zummXD2dvAtI.png","","","","","","1","","","","","","","","","0","","","","","","","","2025-01-15 14:36:54","2025-01-15 15:54:59");
INSERT INTO products VALUES("62","Abe","91033046","standard","C128","4","1","1","1","1","10","100","","-2","","","","","","","","1","zummXD2dvAtI.png","","","","","1","1","","","","","","","","","0","","","","","","","","2025-01-15 15:56:06","2025-01-16 12:09:02");
INSERT INTO products VALUES("63","SS","45631377","standard","C128","","3","1","1","1","10","100","","4","","","","","","","","1","zummXD2dvAtI.png","","","1","","","1","","","","","","","["Color"]","["Black,Silver"]","1","","","","","","","","2025-01-17 00:28:46","2025-01-17 00:30:53");
INSERT INTO products VALUES("64","BB","32674260","standard","C128","2","1","1","1","1","10","100","","1","","","","","","","","1","zummXD2dvAtI.png","","","","","","1","","","","","","","","","1","","","","","","","","2025-01-19 17:17:44","2025-01-19 17:18:31");
INSERT INTO products VALUES("78","aaa","71146219","standard","C128","","5","1","1","1","10","100","","0","","","","","","","","1","zummXD2dvAtI.png","","","","","","","","","","","","","","","0","","","","20","6","","","2025-01-20 17:36:11","2025-01-20 17:37:25");
INSERT INTO products VALUES("79","aaabb","33105716","standard","C128","","2","1","1","1","10","100","","-2","","","","","","","","1","202501231241552.jpg","","0","","","0","","0","","","","","","","","0","","","","4","1","months","years","2025-01-20 17:37:55","2025-01-23 13:09:06");
INSERT INTO products VALUES("80","AABB","99082603","standard","C128","2","1","1","1","1","10","100","","5","","","","","","","","1","zummXD2dvAtI.png","","0","1","","0","1","0","","","","","","["Color"]","["Silver,Red"]","1","","","","2","","years","","2025-01-21 14:12:50","2025-01-26 11:33:23");
INSERT INTO products VALUES("89","Chess","09473213","standard","C128","","45","1","1","1","10","100","","0","","","","","","","","1","202501230113051.jpg","","0","","","0","","0","","","","","","","","0","","","","6","2","months","years","2025-01-23 13:13:05","2025-01-23 13:14:35");
INSERT INTO products VALUES("90","zzz","26612190","standard","C128","2","2","1","1","1","10","100","","-1","","","","","","","","1","zummXD2dvAtI.png","","0","","","0","","0","","","","","","","","1","","","","","","","","2025-01-25 17:18:39","2025-01-26 23:35:36");
INSERT INTO products VALUES("91","Napa","38506193","standard","C128","","47","1","1","1","10","50","","0","","","","","","","","1","zummXD2dvAtI.png","","","","1","","","","","","","","","","","1","","","","","","","","2025-01-27 09:46:07","2025-01-27 09:46:07");



CREATE TABLE `purchase_product_return` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `return_id` int NOT NULL,
  `product_id` int NOT NULL,
  `product_batch_id` int DEFAULT NULL,
  `variant_id` int DEFAULT NULL,
  `imei_number` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `qty` double NOT NULL,
  `purchase_unit_id` int NOT NULL,
  `net_unit_cost` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `purchases` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int NOT NULL,
  `warehouse_id` int NOT NULL,
  `supplier_id` int DEFAULT NULL,
  `currency_id` int DEFAULT NULL,
  `exchange_rate` double DEFAULT NULL,
  `item` int NOT NULL,
  `total_qty` double NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_cost` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `order_discount` double DEFAULT NULL,
  `shipping_cost` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `paid_amount` double NOT NULL,
  `status` int NOT NULL,
  `payment_status` int NOT NULL,
  `document` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO purchases VALUES("1","pr-20240119-074604","1","1","1","1","1","10","100","0","2917.26","44758.8","0","0","0","0","44758.8","0","1","1","","","2024-01-19 19:46:04","2024-01-19 19:46:04");
INSERT INTO purchases VALUES("2","pr-20240119-075004","1","1","1","1","1","10","100","0","3589.09","67113.7","0","0","0","0","67113.7","0","1","1","","","2024-01-19 19:50:04","2024-01-19 19:50:04");
INSERT INTO purchases VALUES("3","pr-20240119-075321","1","1","","1","1","10","100","0","3689.98","49653.7","0","0","0","0","49653.7","0","1","1","","","2024-01-19 19:53:21","2024-01-19 19:53:21");
INSERT INTO purchases VALUES("4","pr-20240119-082648","1","2","1","","","10","101","0","3789.98","50753.69","0","0","0","0","50753.69","0","1","1","","","2024-01-19 00:00:00","2024-01-19 20:26:48");
INSERT INTO purchases VALUES("5","pr-20240119-082826","1","2","1","","","10","100","0","2917.26","44758.8","0","0","0","0","44758.8","0","1","1","","","2024-01-19 00:00:00","2024-01-19 20:28:26");
INSERT INTO purchases VALUES("6","pr-20240119-082835","1","2","1","","","10","100","0","3589.09","67113.7","0","0","0","0","67113.7","0","1","1","","","2024-01-19 00:00:00","2024-01-19 20:28:35");
INSERT INTO purchases VALUES("7","pr-20240119-085202","1","1","1","","","2","2","0","0","748","0","0","0","0","748","0","1","1","","","2024-01-19 20:52:02","2024-01-19 20:52:02");
INSERT INTO purchases VALUES("8","pr-20240204-011347","1","1","","1","1","1","6","0","480","5280","0","0","0","0","5280","0","1","1","","","2024-02-04 00:00:00","2024-06-20 11:08:26");
INSERT INTO purchases VALUES("9","pr-20240718-014145","1","1","1","1","1","1","5","0","0","500","0","0","0","0","500","0","1","1","","","2024-07-18 13:41:45","2024-07-18 13:41:45");
INSERT INTO purchases VALUES("10","pr-20240718-014928","1","2","2","","","1","5","0","0","500","0","0","0","0","500","0","1","1","","","2024-07-18 00:00:00","2024-07-18 13:51:35");
INSERT INTO purchases VALUES("11","pr-20241124-030222","1","1","1","1","1","1","10","0","0","1000","0","0","0","0","1000","0","1","1","","","2024-11-24 15:02:22","2024-11-24 15:02:22");
INSERT INTO purchases VALUES("12","pr-20241202-024402","1","1","","","","1","10","0","145","870","","0","","","870","870","1","2","","","2024-12-02 14:44:02","2024-12-02 14:44:02");
INSERT INTO purchases VALUES("13","pr-20241202-024402","1","2","","","","1","47","0","681.5","4089","","0","","","4089","4089","1","2","","","2024-12-02 14:44:02","2024-12-02 14:44:02");
INSERT INTO purchases VALUES("14","pr-20241219-112801","1","1","1","1","1","3","9","0","0","1350","0","0","0","0","1350","1350","1","2","","","2024-12-19 11:28:01","2024-12-19 11:28:10");
INSERT INTO purchases VALUES("15","pr-20241219-114033","1","1","1","1","1","2","20","0","0","100","0","0","0","0","100","0","1","1","","","2024-12-19 11:40:33","2024-12-19 11:40:33");
INSERT INTO purchases VALUES("16","pr-20250108-123927","1","1","","1","1","1","1","0","27.27","300","0","0","0","0","300","0","1","1","","","2025-01-08 00:00:00","2025-01-08 12:39:27");
INSERT INTO purchases VALUES("17","pr-20250108-125911","1","1","","","","3","20","0","0","66.25","0","0","","","66.25","0","1","1","","","2025-01-08 12:59:11","2025-01-08 12:59:11");
INSERT INTO purchases VALUES("18","pr-20250108-024142","1","1","","","","1","10","0","0","100","","0","","","100","100","1","2","","","2025-01-08 14:41:42","2025-01-08 14:41:42");
INSERT INTO purchases VALUES("23","pr-20250108-065125","1","1","","1","1","1","2","0","0","20","0","0","0","0","20","0","1","1","","","2025-01-08 18:51:25","2025-01-08 18:51:25");
INSERT INTO purchases VALUES("40","pr-20250112-011924","1","1","","","","1","10","0","0","100","","0","","","100","100","1","2","","","2025-01-12 13:19:24","2025-01-12 13:19:24");
INSERT INTO purchases VALUES("41","pr-20250112-011924","1","2","","","","1","10","0","0","100","","0","","","100","100","1","2","","","2025-01-12 13:19:24","2025-01-12 13:19:24");
INSERT INTO purchases VALUES("42","pr-20250112-012128","1","1","","1","1","1","2","0","0","20","0","0","0","0","20","0","1","1","","","2025-01-12 13:21:28","2025-01-12 13:21:28");
INSERT INTO purchases VALUES("43","pr-20250112-012224","1","1","","1","1","1","2","0","0","20","0","0","0","0","20","0","1","1","","","2025-01-12 13:22:24","2025-01-12 13:22:24");
INSERT INTO purchases VALUES("44","pr-20250112-015323","1","1","","1","1","1","2","0","0","20","0","0","0","0","20","0","1","1","","","2025-01-12 13:53:23","2025-01-12 13:53:23");
INSERT INTO purchases VALUES("45","pr-20250112-052900","1","1","","1","1","1","1","0","0","10","0","0","0","0","10","0","1","1","","","2025-01-12 17:29:00","2025-01-12 17:29:00");
INSERT INTO purchases VALUES("47","pr-20250113-020754","1","1","","1","1","1","2","0","0","20","0","0","0","0","20","0","1","1","","","2025-01-13 14:07:54","2025-01-13 14:07:54");
INSERT INTO purchases VALUES("48","pr-20250113-020843","1","1","","1","1","1","2","0","0","20","0","0","0","0","20","0","1","1","","","2025-01-13 14:08:43","2025-01-13 14:08:43");
INSERT INTO purchases VALUES("57","pr-20250116-120932","1","1","","1","1","1","2","0","0","20","0","0","0","0","20","0","1","1","","","2025-01-16 12:09:32","2025-01-16 12:09:32");
INSERT INTO purchases VALUES("58","pr-20250117-122535","1","1","","1","1","1","2","0","0","20","0","0","0","0","20","0","1","1","","","2025-01-17 00:25:35","2025-01-17 00:25:35");
INSERT INTO purchases VALUES("59","pr-20250117-123053","1","1","","1","1","2","4","0","0","40","0","0","0","0","40","0","1","1","","","2025-01-17 00:30:53","2025-01-17 00:30:53");
INSERT INTO purchases VALUES("60","pr-20250119-051809","1","1","","1","1","1","2","0","0","20","0","0","0","0","20","0","1","1","","","2025-01-19 17:18:09","2025-01-19 17:18:09");
INSERT INTO purchases VALUES("63","pr-20250121-021540","1","1","","1","1","1","4","0","0","40","0","0","0","0","40","0","1","1","","","2025-01-21 14:15:40","2025-01-21 14:15:40");
INSERT INTO purchases VALUES("64","pr-20250121-021618","1","1","","1","1","1","2","0","0","20","0","0","0","0","20","0","1","1","","","2025-01-21 14:16:18","2025-01-21 14:16:18");



CREATE TABLE `quotations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int NOT NULL,
  `biller_id` int NOT NULL,
  `supplier_id` int DEFAULT NULL,
  `customer_id` int NOT NULL,
  `warehouse_id` int NOT NULL,
  `item` int NOT NULL,
  `total_qty` double NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_price` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `order_discount` double DEFAULT NULL,
  `shipping_cost` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `quotation_status` int NOT NULL,
  `document` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO quotations VALUES("1","qr-20240119-085132","1","1","1","1","1","2","2","0","0","998","0","0","","","998","1","","","2024-01-19 20:51:32","2024-01-19 20:51:32");
INSERT INTO quotations VALUES("2","qr-20240825-060117","1","1","1","2","1","1","3","0","0","1497","0","0","","","1497","1","","","2024-08-26 05:01:17","2024-08-26 05:01:17");
INSERT INTO quotations VALUES("3","qr-20241127-030938","1","1","1","1","1","1","1","0","0","577","0","0","","","577","1","","","2024-11-27 15:09:38","2024-11-27 15:09:38");



CREATE TABLE `return_purchases` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `supplier_id` int DEFAULT NULL,
  `warehouse_id` int NOT NULL,
  `user_id` int NOT NULL,
  `purchase_id` int DEFAULT NULL,
  `account_id` int NOT NULL,
  `currency_id` int DEFAULT NULL,
  `exchange_rate` double DEFAULT NULL,
  `item` int NOT NULL,
  `total_qty` double NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_cost` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `document` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `return_note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `staff_note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `returns` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int NOT NULL,
  `sale_id` int DEFAULT NULL,
  `cash_register_id` int DEFAULT NULL,
  `customer_id` int NOT NULL,
  `warehouse_id` int NOT NULL,
  `biller_id` int NOT NULL,
  `account_id` int NOT NULL,
  `currency_id` int DEFAULT NULL,
  `exchange_rate` double DEFAULT NULL,
  `item` int NOT NULL,
  `total_qty` double NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_price` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `document` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `return_note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `staff_note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO returns VALUES("1","rr-20240324-010823","1","8","2","2","1","1","1","1","1","1","1","0","118.18","1299.99","0","0","1299.99","","","","2024-03-24 13:08:23","2024-03-24 13:08:23");
INSERT INTO returns VALUES("2","rr-20240429-063038","1","14","2","2","1","1","1","1","1","2","2","0","136.46","1500.99","0","0","1500.99","","","","2024-04-29 18:30:38","2024-04-29 18:30:38");
INSERT INTO returns VALUES("3","rr-20240626-010142","1","33","2","2","1","1","1","1","1","1","1","0","118.18","1299.99","0","0","1299.99","","","","2024-06-26 13:01:42","2024-06-26 13:01:42");



CREATE TABLE `reward_point_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `per_point_amount` double NOT NULL,
  `minimum_amount` double NOT NULL,
  `duration` int DEFAULT NULL,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO reward_point_settings VALUES("1","300","1000","1","Year","1","2021-06-08 21:40:15","2021-06-27 11:20:55");



CREATE TABLE `role_has_permissions` (
  `permission_id` int unsigned NOT NULL,
  `role_id` int unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO role_has_permissions VALUES("4","1");
INSERT INTO role_has_permissions VALUES("5","1");
INSERT INTO role_has_permissions VALUES("6","1");
INSERT INTO role_has_permissions VALUES("7","1");
INSERT INTO role_has_permissions VALUES("8","1");
INSERT INTO role_has_permissions VALUES("9","1");
INSERT INTO role_has_permissions VALUES("10","1");
INSERT INTO role_has_permissions VALUES("11","1");
INSERT INTO role_has_permissions VALUES("12","1");
INSERT INTO role_has_permissions VALUES("13","1");
INSERT INTO role_has_permissions VALUES("14","1");
INSERT INTO role_has_permissions VALUES("15","1");
INSERT INTO role_has_permissions VALUES("16","1");
INSERT INTO role_has_permissions VALUES("17","1");
INSERT INTO role_has_permissions VALUES("18","1");
INSERT INTO role_has_permissions VALUES("19","1");
INSERT INTO role_has_permissions VALUES("20","1");
INSERT INTO role_has_permissions VALUES("21","1");
INSERT INTO role_has_permissions VALUES("22","1");
INSERT INTO role_has_permissions VALUES("23","1");
INSERT INTO role_has_permissions VALUES("24","1");
INSERT INTO role_has_permissions VALUES("25","1");
INSERT INTO role_has_permissions VALUES("26","1");
INSERT INTO role_has_permissions VALUES("27","1");
INSERT INTO role_has_permissions VALUES("28","1");
INSERT INTO role_has_permissions VALUES("29","1");
INSERT INTO role_has_permissions VALUES("30","1");
INSERT INTO role_has_permissions VALUES("31","1");
INSERT INTO role_has_permissions VALUES("32","1");
INSERT INTO role_has_permissions VALUES("33","1");
INSERT INTO role_has_permissions VALUES("34","1");
INSERT INTO role_has_permissions VALUES("35","1");
INSERT INTO role_has_permissions VALUES("36","1");
INSERT INTO role_has_permissions VALUES("37","1");
INSERT INTO role_has_permissions VALUES("38","1");
INSERT INTO role_has_permissions VALUES("39","1");
INSERT INTO role_has_permissions VALUES("40","1");
INSERT INTO role_has_permissions VALUES("41","1");
INSERT INTO role_has_permissions VALUES("42","1");
INSERT INTO role_has_permissions VALUES("43","1");
INSERT INTO role_has_permissions VALUES("44","1");
INSERT INTO role_has_permissions VALUES("45","1");
INSERT INTO role_has_permissions VALUES("46","1");
INSERT INTO role_has_permissions VALUES("47","1");
INSERT INTO role_has_permissions VALUES("48","1");
INSERT INTO role_has_permissions VALUES("49","1");
INSERT INTO role_has_permissions VALUES("50","1");
INSERT INTO role_has_permissions VALUES("51","1");
INSERT INTO role_has_permissions VALUES("52","1");
INSERT INTO role_has_permissions VALUES("53","1");
INSERT INTO role_has_permissions VALUES("54","1");
INSERT INTO role_has_permissions VALUES("55","1");
INSERT INTO role_has_permissions VALUES("56","1");
INSERT INTO role_has_permissions VALUES("57","1");
INSERT INTO role_has_permissions VALUES("58","1");
INSERT INTO role_has_permissions VALUES("59","1");
INSERT INTO role_has_permissions VALUES("60","1");
INSERT INTO role_has_permissions VALUES("61","1");
INSERT INTO role_has_permissions VALUES("62","1");
INSERT INTO role_has_permissions VALUES("63","1");
INSERT INTO role_has_permissions VALUES("64","1");
INSERT INTO role_has_permissions VALUES("65","1");
INSERT INTO role_has_permissions VALUES("66","1");
INSERT INTO role_has_permissions VALUES("67","1");
INSERT INTO role_has_permissions VALUES("68","1");
INSERT INTO role_has_permissions VALUES("69","1");
INSERT INTO role_has_permissions VALUES("70","1");
INSERT INTO role_has_permissions VALUES("71","1");
INSERT INTO role_has_permissions VALUES("72","1");
INSERT INTO role_has_permissions VALUES("73","1");
INSERT INTO role_has_permissions VALUES("74","1");
INSERT INTO role_has_permissions VALUES("75","1");
INSERT INTO role_has_permissions VALUES("76","1");
INSERT INTO role_has_permissions VALUES("77","1");
INSERT INTO role_has_permissions VALUES("78","1");
INSERT INTO role_has_permissions VALUES("79","1");
INSERT INTO role_has_permissions VALUES("80","1");
INSERT INTO role_has_permissions VALUES("81","1");
INSERT INTO role_has_permissions VALUES("82","1");
INSERT INTO role_has_permissions VALUES("83","1");
INSERT INTO role_has_permissions VALUES("84","1");
INSERT INTO role_has_permissions VALUES("85","1");
INSERT INTO role_has_permissions VALUES("86","1");
INSERT INTO role_has_permissions VALUES("87","1");
INSERT INTO role_has_permissions VALUES("88","1");
INSERT INTO role_has_permissions VALUES("89","1");
INSERT INTO role_has_permissions VALUES("90","1");
INSERT INTO role_has_permissions VALUES("91","1");
INSERT INTO role_has_permissions VALUES("92","1");
INSERT INTO role_has_permissions VALUES("93","1");
INSERT INTO role_has_permissions VALUES("94","1");
INSERT INTO role_has_permissions VALUES("95","1");
INSERT INTO role_has_permissions VALUES("96","1");
INSERT INTO role_has_permissions VALUES("97","1");
INSERT INTO role_has_permissions VALUES("98","1");
INSERT INTO role_has_permissions VALUES("99","1");
INSERT INTO role_has_permissions VALUES("100","1");
INSERT INTO role_has_permissions VALUES("101","1");
INSERT INTO role_has_permissions VALUES("102","1");
INSERT INTO role_has_permissions VALUES("103","1");
INSERT INTO role_has_permissions VALUES("104","1");
INSERT INTO role_has_permissions VALUES("105","1");
INSERT INTO role_has_permissions VALUES("106","1");
INSERT INTO role_has_permissions VALUES("107","1");
INSERT INTO role_has_permissions VALUES("108","1");
INSERT INTO role_has_permissions VALUES("109","1");
INSERT INTO role_has_permissions VALUES("110","1");
INSERT INTO role_has_permissions VALUES("111","1");
INSERT INTO role_has_permissions VALUES("112","1");
INSERT INTO role_has_permissions VALUES("113","1");
INSERT INTO role_has_permissions VALUES("114","1");
INSERT INTO role_has_permissions VALUES("115","1");
INSERT INTO role_has_permissions VALUES("116","1");
INSERT INTO role_has_permissions VALUES("117","1");
INSERT INTO role_has_permissions VALUES("118","1");
INSERT INTO role_has_permissions VALUES("119","1");
INSERT INTO role_has_permissions VALUES("120","1");
INSERT INTO role_has_permissions VALUES("121","1");
INSERT INTO role_has_permissions VALUES("122","1");
INSERT INTO role_has_permissions VALUES("123","1");
INSERT INTO role_has_permissions VALUES("124","1");
INSERT INTO role_has_permissions VALUES("125","1");
INSERT INTO role_has_permissions VALUES("126","1");
INSERT INTO role_has_permissions VALUES("127","1");
INSERT INTO role_has_permissions VALUES("128","1");
INSERT INTO role_has_permissions VALUES("129","1");
INSERT INTO role_has_permissions VALUES("130","1");
INSERT INTO role_has_permissions VALUES("131","1");
INSERT INTO role_has_permissions VALUES("132","1");
INSERT INTO role_has_permissions VALUES("4","2");
INSERT INTO role_has_permissions VALUES("5","2");
INSERT INTO role_has_permissions VALUES("6","2");
INSERT INTO role_has_permissions VALUES("7","2");
INSERT INTO role_has_permissions VALUES("8","2");
INSERT INTO role_has_permissions VALUES("9","2");
INSERT INTO role_has_permissions VALUES("10","2");
INSERT INTO role_has_permissions VALUES("11","2");
INSERT INTO role_has_permissions VALUES("12","2");
INSERT INTO role_has_permissions VALUES("13","2");
INSERT INTO role_has_permissions VALUES("14","2");
INSERT INTO role_has_permissions VALUES("15","2");
INSERT INTO role_has_permissions VALUES("16","2");
INSERT INTO role_has_permissions VALUES("17","2");
INSERT INTO role_has_permissions VALUES("18","2");
INSERT INTO role_has_permissions VALUES("19","2");
INSERT INTO role_has_permissions VALUES("20","2");
INSERT INTO role_has_permissions VALUES("21","2");
INSERT INTO role_has_permissions VALUES("22","2");
INSERT INTO role_has_permissions VALUES("23","2");
INSERT INTO role_has_permissions VALUES("24","2");
INSERT INTO role_has_permissions VALUES("25","2");
INSERT INTO role_has_permissions VALUES("26","2");
INSERT INTO role_has_permissions VALUES("27","2");
INSERT INTO role_has_permissions VALUES("28","2");
INSERT INTO role_has_permissions VALUES("29","2");
INSERT INTO role_has_permissions VALUES("30","2");
INSERT INTO role_has_permissions VALUES("31","2");
INSERT INTO role_has_permissions VALUES("32","2");
INSERT INTO role_has_permissions VALUES("33","2");
INSERT INTO role_has_permissions VALUES("34","2");
INSERT INTO role_has_permissions VALUES("35","2");
INSERT INTO role_has_permissions VALUES("36","2");
INSERT INTO role_has_permissions VALUES("37","2");
INSERT INTO role_has_permissions VALUES("38","2");
INSERT INTO role_has_permissions VALUES("39","2");
INSERT INTO role_has_permissions VALUES("40","2");
INSERT INTO role_has_permissions VALUES("41","2");
INSERT INTO role_has_permissions VALUES("42","2");
INSERT INTO role_has_permissions VALUES("43","2");
INSERT INTO role_has_permissions VALUES("44","2");
INSERT INTO role_has_permissions VALUES("45","2");
INSERT INTO role_has_permissions VALUES("46","2");
INSERT INTO role_has_permissions VALUES("47","2");
INSERT INTO role_has_permissions VALUES("48","2");
INSERT INTO role_has_permissions VALUES("49","2");
INSERT INTO role_has_permissions VALUES("50","2");
INSERT INTO role_has_permissions VALUES("51","2");
INSERT INTO role_has_permissions VALUES("52","2");
INSERT INTO role_has_permissions VALUES("53","2");
INSERT INTO role_has_permissions VALUES("54","2");
INSERT INTO role_has_permissions VALUES("55","2");
INSERT INTO role_has_permissions VALUES("56","2");
INSERT INTO role_has_permissions VALUES("57","2");
INSERT INTO role_has_permissions VALUES("58","2");
INSERT INTO role_has_permissions VALUES("59","2");
INSERT INTO role_has_permissions VALUES("60","2");
INSERT INTO role_has_permissions VALUES("61","2");
INSERT INTO role_has_permissions VALUES("62","2");
INSERT INTO role_has_permissions VALUES("63","2");
INSERT INTO role_has_permissions VALUES("64","2");
INSERT INTO role_has_permissions VALUES("65","2");
INSERT INTO role_has_permissions VALUES("66","2");
INSERT INTO role_has_permissions VALUES("67","2");
INSERT INTO role_has_permissions VALUES("68","2");
INSERT INTO role_has_permissions VALUES("69","2");
INSERT INTO role_has_permissions VALUES("70","2");
INSERT INTO role_has_permissions VALUES("71","2");
INSERT INTO role_has_permissions VALUES("72","2");
INSERT INTO role_has_permissions VALUES("73","2");
INSERT INTO role_has_permissions VALUES("74","2");
INSERT INTO role_has_permissions VALUES("75","2");
INSERT INTO role_has_permissions VALUES("76","2");
INSERT INTO role_has_permissions VALUES("77","2");
INSERT INTO role_has_permissions VALUES("78","2");
INSERT INTO role_has_permissions VALUES("79","2");
INSERT INTO role_has_permissions VALUES("80","2");
INSERT INTO role_has_permissions VALUES("81","2");
INSERT INTO role_has_permissions VALUES("82","2");
INSERT INTO role_has_permissions VALUES("83","2");
INSERT INTO role_has_permissions VALUES("84","2");
INSERT INTO role_has_permissions VALUES("85","2");
INSERT INTO role_has_permissions VALUES("86","2");
INSERT INTO role_has_permissions VALUES("87","2");
INSERT INTO role_has_permissions VALUES("88","2");
INSERT INTO role_has_permissions VALUES("89","2");
INSERT INTO role_has_permissions VALUES("90","2");
INSERT INTO role_has_permissions VALUES("91","2");
INSERT INTO role_has_permissions VALUES("92","2");
INSERT INTO role_has_permissions VALUES("93","2");
INSERT INTO role_has_permissions VALUES("94","2");
INSERT INTO role_has_permissions VALUES("95","2");
INSERT INTO role_has_permissions VALUES("96","2");
INSERT INTO role_has_permissions VALUES("97","2");
INSERT INTO role_has_permissions VALUES("98","2");
INSERT INTO role_has_permissions VALUES("99","2");
INSERT INTO role_has_permissions VALUES("100","2");
INSERT INTO role_has_permissions VALUES("101","2");
INSERT INTO role_has_permissions VALUES("102","2");
INSERT INTO role_has_permissions VALUES("103","2");
INSERT INTO role_has_permissions VALUES("104","2");
INSERT INTO role_has_permissions VALUES("105","2");
INSERT INTO role_has_permissions VALUES("6","4");
INSERT INTO role_has_permissions VALUES("7","4");
INSERT INTO role_has_permissions VALUES("8","4");
INSERT INTO role_has_permissions VALUES("9","4");
INSERT INTO role_has_permissions VALUES("12","4");
INSERT INTO role_has_permissions VALUES("13","4");
INSERT INTO role_has_permissions VALUES("14","4");
INSERT INTO role_has_permissions VALUES("20","4");
INSERT INTO role_has_permissions VALUES("21","4");
INSERT INTO role_has_permissions VALUES("22","4");
INSERT INTO role_has_permissions VALUES("24","4");
INSERT INTO role_has_permissions VALUES("25","4");
INSERT INTO role_has_permissions VALUES("28","4");
INSERT INTO role_has_permissions VALUES("29","4");
INSERT INTO role_has_permissions VALUES("55","4");
INSERT INTO role_has_permissions VALUES("56","4");
INSERT INTO role_has_permissions VALUES("57","4");
INSERT INTO role_has_permissions VALUES("63","4");
INSERT INTO role_has_permissions VALUES("64","4");
INSERT INTO role_has_permissions VALUES("89","4");
INSERT INTO role_has_permissions VALUES("106","4");



CREATE TABLE `roles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `guard_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO roles VALUES("1","Admin","admin can access all data...","web","1","2018-06-02 05:46:44","2018-06-03 05:13:05");
INSERT INTO roles VALUES("2","Owner","Staff of shop","web","1","2018-10-22 08:38:13","2022-02-01 19:13:30");
INSERT INTO roles VALUES("4","staff","staff has specific acess...","web","1","2018-06-02 06:05:27","2022-02-01 19:13:04");
INSERT INTO roles VALUES("5","Customer","","web","1","2020-11-05 12:43:16","2020-11-15 06:24:15");



CREATE TABLE `sales` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int NOT NULL,
  `cash_register_id` int DEFAULT NULL,
  `table_id` int DEFAULT NULL,
  `queue` int DEFAULT NULL,
  `customer_id` int NOT NULL,
  `warehouse_id` int NOT NULL,
  `biller_id` int DEFAULT NULL,
  `item` int NOT NULL,
  `total_qty` double NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_price` double NOT NULL,
  `grand_total` double NOT NULL,
  `currency_id` int DEFAULT NULL,
  `exchange_rate` double DEFAULT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `order_discount_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_discount_value` double DEFAULT NULL,
  `order_discount` double DEFAULT NULL,
  `coupon_id` int DEFAULT NULL,
  `coupon_discount` double DEFAULT NULL,
  `shipping_cost` double DEFAULT NULL,
  `sale_status` int NOT NULL,
  `payment_status` int NOT NULL,
  `document` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid_amount` double DEFAULT NULL,
  `sale_note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `staff_note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `woocommerce_order_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=197 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO sales VALUES("1","posr-20240119-084016","1","","","","1","1","1","2","2","0","159.81","1758","1758","1","1","0","0","Flat","","0","","","0","1","4","","1758","","","","2024-01-19 20:40:16","2024-01-19 20:40:16");
INSERT INTO sales VALUES("2","posr-20240119-084441","1","","","","1","2","1","5","6","0","213.54","3017","3017","1","1","0","0","Flat","","0","","","0","1","4","","3017","","","","2024-01-19 20:44:41","2024-01-19 20:44:41");
INSERT INTO sales VALUES("3","sr-20240119-084833","1","1","","","2","2","1","3","5","0","54.45","1182","1182","1","1","0","0","Flat","","0","","","0","1","1","","","","","","2024-01-19 20:48:33","2024-01-19 20:48:33");
INSERT INTO sales VALUES("4","sr-20240119-085242","1","2","","","1","1","1","3","3","0","90.82","1997","1997","","","0","0","Flat","0","0","","","0","1","2","","","","","","2024-01-19 00:00:00","2024-01-19 20:53:31");
INSERT INTO sales VALUES("5","posr-20240210-122224","1","2","","","2","1","1","1","1","0","114.45","1259","1259","1","1","0","0","Flat","","0","","","0","1","4","","1259","","","","2024-02-10 12:22:24","2024-02-10 12:22:24");
INSERT INTO sales VALUES("6","posr-20240225-014951","1","2","","","2","1","1","1","1","0","118.18","1299.99","1299.99","1","1","0","0","Flat","","0","","","0","1","4","","1299.99","","","","2024-02-25 13:49:51","2024-02-25 13:49:51");
INSERT INTO sales VALUES("7","posr-20240225-015013","1","2","","","2","1","1","1","2","0","236.36","2599.98","2599.98","1","1","0","0","Flat","","0","","","0","1","4","","2599.98","","","","2024-02-25 13:50:13","2024-02-25 13:50:13");
INSERT INTO sales VALUES("8","posr-20240228-112744","1","2","","","2","1","1","2","2","0","232.63","2558.99","2558.99","1","1","0","0","Flat","","0","","","0","1","4","","2558.99","","","","2024-02-28 11:27:44","2024-02-28 11:27:44");
INSERT INTO sales VALUES("9","posr-20240421-110143","1","2","1","1","2","1","1","1","1","0","31.82","350","350","1","1","0","0","Flat","","0","","","0","1","4","","350","","","","2024-04-21 11:01:43","2024-04-21 11:01:43");
INSERT INTO sales VALUES("13","posr-20240428-121544","1","2","","","2","1","1","2","2","0","128.09","1409","1409","1","1","","0","","","0","","","0","1","4","","1409","","","","2024-04-28 12:15:44","2024-04-28 12:15:44");
INSERT INTO sales VALUES("14","posr-20240429-062956","1","2","","","2","1","1","4","4","0","345.55","3800.99","3800.99","1","1","0","0","Flat","","0","","","0","1","4","","3800.99","","","","2024-04-29 18:29:56","2024-04-29 18:29:56");
INSERT INTO sales VALUES("15","sr-20240505-111902","1","2","","","2","1","1","1","1","0","0","499","499","1","1","0","0","Flat","","0","","","0","1","2","","0","","","","2024-05-05 11:19:02","2024-05-05 11:20:14");
INSERT INTO sales VALUES("20","posr-20240505-052905","1","2","","","2","1","1","2","2","0","231.82","2549.99","2549.99","1","1","","0","","","0","","","0","1","4","","2549.99","","","","2024-05-05 17:29:05","2024-05-05 17:29:05");
INSERT INTO sales VALUES("22","posr-20240508-020851","1","2","","","2","1","1","2","2","0","122.73","1349.99","1349.99","1","1","","0","","","0","","","0","1","4","","1349.99","","","","2024-05-08 14:08:51","2024-05-08 14:08:51");
INSERT INTO sales VALUES("23","posr-20240519-022423","1","2","","","2","1","1","1","1","0","118.18","1299.99","1299.99","1","1","0","0","Flat","","0","","","0","1","4","","1299.99","","","","2024-05-19 14:24:23","2024-05-19 14:24:23");
INSERT INTO sales VALUES("24","posr-20240519-022530","1","2","","","2","1","1","1","1","0","118.18","1300","1300","1","1","0","0","Flat","","0","","","0","1","4","","1300","","","","2024-05-19 14:25:30","2024-05-19 14:25:30");
INSERT INTO sales VALUES("25","posr-20240519-023055","1","2","","","2","1","1","1","1","0","118.18","1300","1300","1","1","0","0","Flat","","0","","","0","1","4","","1300","","","","2024-05-19 14:30:55","2024-05-19 14:30:55");
INSERT INTO sales VALUES("28","posr-20240521-013249","1","2","","","2","1","1","1","1","0","95.45","1050","1050","1","1","0","0","Flat","","0","","","0","1","4","","1050","","","","2024-05-21 13:32:49","2024-05-21 13:32:49");
INSERT INTO sales VALUES("29","posr-20240603-122651","1","2","","","2","1","1","2","2","0","231.82","2549.99","2549.99","1","1","0","0","Flat","","0","","","0","1","4","","2549.99","","","","2024-06-03 12:26:51","2024-06-03 12:29:06");
INSERT INTO sales VALUES("30","posr-20240603-053015","1","2","","","2","1","1","2","2","0","209.09","2300","2300","1","1","0","0","Flat","","0","","","0","1","4","","2300","","","","2024-06-03 17:30:15","2024-06-03 17:30:15");
INSERT INTO sales VALUES("31","sr-20240603-053058","1","2","","","1","1","1","1","1","0","0","577","577","1","1","0","0","Flat","","0","","","0","1","1","","","","","","2024-06-03 17:30:58","2024-06-03 17:30:58");
INSERT INTO sales VALUES("32","posr-20240620-015456","1","2","","","2","1","1","1","1","0","118.18","1299.99","1299.99","1","1","0","0","Flat","","0","","","0","3","2","","","","","","2024-06-20 13:54:56","2024-06-20 13:54:56");
INSERT INTO sales VALUES("33","posr-20240626-010115","1","2","","","2","1","1","1","1","0","118.18","1299.99","1299.99","1","1","0","0","Flat","","0","","","0","4","4","","1299.99","","","","2024-06-26 13:01:15","2024-06-26 13:01:42");
INSERT INTO sales VALUES("36","sr-20240711-121041","1","2","","","1","1","1","1","1","0","0","577","577","1","1","0","0","Flat","","0","","","0","1","1","","","","","","2024-07-08 00:00:00","2024-07-11 12:10:41");
INSERT INTO sales VALUES("38","posr-20240718-113630","1","2","","","2","1","1","1","1","0","118.18","1299.99","1299.99","1","1","0","0","Flat","","0","","","0","1","4","","1299.99","","","","2024-07-18 11:36:30","2024-07-18 11:36:30");
INSERT INTO sales VALUES("39","posr-20240718-015913","1","2","","","2","1","1","1","1","0","0","250","250","1","1","0","0","Flat","","0","","","0","1","4","","250","","","","2024-07-18 13:59:13","2024-07-18 13:59:13");
INSERT INTO sales VALUES("40","posr-20240718-020145","1","1","","","2","2","1","1","1","0","0","250","250","1","1","0","0","Flat","","0","","","0","1","4","","250","","","","2024-07-18 14:01:45","2024-07-18 14:01:45");
INSERT INTO sales VALUES("42","sr-20240811-110629","1","2","","","2","1","1","1","1","0","0","577","577","1","1","0","0","Flat","","0","","","0","1","4","","577","","","","2024-08-11 11:06:29","2024-08-11 11:28:06");
INSERT INTO sales VALUES("43","sr-20240811-113722","1","1","","","2","2","1","1","1","0","54.45","599","599","1","1","0","0","Flat","","0","","","0","5","1","","","","","","2024-08-11 11:37:22","2024-08-11 11:37:38");
INSERT INTO sales VALUES("45","posr-20240811-114852","1","2","","","2","1","1","2","2","0","145.46","1600","1600","1","1","","0","","","0","","","0","1","4","","1600","","","","2024-08-11 11:48:52","2024-08-11 11:48:52");
INSERT INTO sales VALUES("46","posr-20240825-062616","1","3","","","2","1","1","1","1","0","118.18","1299.99","1299.99","1","1","","0","Flat","","0","","","0","1","4","","1299.99","","","","2024-08-26 05:26:16","2024-08-26 05:26:16");
INSERT INTO sales VALUES("47","posr-20240825-062630","1","3","","","2","1","1","1","1","0","95.45","1050","1050","1","1","0","0","Flat","","0","","","0","1","4","","1050","","","","2024-08-26 05:26:30","2024-08-26 05:26:30");
INSERT INTO sales VALUES("50","posr-20240825-062929","1","3","","","2","1","1","1","1","0","31.82","350","350","1","1","","0","Flat","","0","","","0","1","4","","350","","","","2024-08-26 05:29:29","2024-08-26 05:29:29");
INSERT INTO sales VALUES("51","sr-20241124-030258","1","3","","","1","1","1","1","1","0","0","150","150","1","1","0","0","Flat","","0","","","0","1","1","","0","","","","2024-11-24 15:02:58","2024-11-24 15:02:58");
INSERT INTO sales VALUES("52","sr-20241124-030425","1","3","","","1","1","1","1","1","0","0","150","150","1","1","0","0","Flat","0","0","","","0","1","2","","0","","","","2024-11-24 00:00:00","2024-11-24 16:44:05");
INSERT INTO sales VALUES("53","sr-20241124-044702","1","3","","","2","1","1","1","1","0","0","250","250","1","1","0","0","Flat","0","0","","","0","1","2","","0","","","","2024-11-24 00:00:00","2024-11-24 16:47:26");
INSERT INTO sales VALUES("54","sr-20241127-031418","1","3","","","1","1","1","1","1","0","0","577","577","","","0","0","Flat","0","","","","0","1","1","","","","","","2024-11-27 15:14:18","2024-11-27 15:14:18");
INSERT INTO sales VALUES("55","sr-20241127-050418","1","3","","","1","1","1","1","1","0","0","577","577","","","0","0","Flat","0","","","","0","1","1","","0","","","","2024-11-27 17:04:18","2024-11-27 17:04:18");
INSERT INTO sales VALUES("56","sr-20241127-050522","1","3","","","1","1","1","2","2","0","0","998","998","","","0","0","Flat","0","","","","0","1","1","","0","","","","2024-11-27 17:05:22","2024-11-27 17:05:22");
INSERT INTO sales VALUES("57","sr-20241127-050726","1","3","","","1","1","1","2","2","0","0","998","998","","","0","0","Flat","0","","","","0","1","1","","0","","","","2024-11-27 17:07:26","2024-11-27 17:07:26");
INSERT INTO sales VALUES("58","sr-20241127-051804","1","3","","","1","1","1","2","2","0","0","998","998","","","0","0","Flat","0","","","","0","1","1","","0","","","","2024-11-27 17:18:04","2024-11-27 17:18:04");
INSERT INTO sales VALUES("59","sr-20241127-052204","1","3","","","1","1","1","2","2","0","0","998","998","","","0","0","Flat","0","","","","0","1","1","","0","","","","2024-11-27 17:22:04","2024-11-27 17:22:04");
INSERT INTO sales VALUES("60","sr-20241127-052237","1","3","","","1","1","1","2","2","0","0","998","998","","","0","0","Flat","0","","","","0","1","1","","0","","","","2024-11-27 17:22:37","2024-11-27 17:22:37");
INSERT INTO sales VALUES("61","sr-20241127-054116","1","3","","","1","1","1","2","2","0","0","998","998","","","0","0","Flat","0","","","","0","1","1","","0","","","","2024-11-27 17:41:16","2024-11-27 17:41:16");
INSERT INTO sales VALUES("62","sr-20241127-054159","1","3","","","1","1","1","2","2","0","0","998","998","","","0","0","Flat","0","","","","0","1","1","","0","","","","2024-11-27 17:41:59","2024-11-27 17:41:59");
INSERT INTO sales VALUES("63","sr-20241127-054351","1","3","","","1","1","1","2","2","0","0","998","998","","","0","0","Flat","0","","","","0","1","1","","0","","","","2024-11-27 17:43:51","2024-11-27 17:43:51");
INSERT INTO sales VALUES("64","sr-20241127-054650","1","3","","","1","1","1","2","2","0","0","998","998","","","0","0","Flat","0","","","","0","1","1","","0","","","","2024-11-27 17:46:50","2024-11-27 17:46:50");
INSERT INTO sales VALUES("65","sr-20241127-054819","1","3","","","1","1","1","2","2","0","0","998","998","","","0","0","Flat","0","","","","0","1","1","","0","","","","2024-11-27 17:48:19","2024-11-27 17:48:19");
INSERT INTO sales VALUES("66","sr-20241127-054947","1","3","","","1","1","1","2","2","0","0","998","998","","","0","0","Flat","0","","","","0","1","1","","0","","","","2024-11-27 17:49:47","2024-11-27 17:49:47");
INSERT INTO sales VALUES("67","sr-20241127-054955","1","3","","","1","1","1","2","2","0","0","998","998","","","0","0","Flat","0","","","","0","1","1","","0","","","","2024-11-27 17:49:55","2024-11-27 17:49:55");
INSERT INTO sales VALUES("68","sr-20241127-055034","1","3","","","1","1","1","2","2","0","0","998","998","","","0","0","Flat","0","","","","0","1","1","","0","","","","2024-11-27 17:50:34","2024-11-27 17:50:34");
INSERT INTO sales VALUES("69","sr-20241127-055128","1","3","","","1","1","1","2","2","0","0","998","998","","","0","0","Flat","0","","","","0","1","1","","0","","","","2024-11-27 17:51:28","2024-11-27 17:51:28");
INSERT INTO sales VALUES("70","sr-20241127-055219","1","3","","","1","1","1","1","1","0","0","577","577","","","0","0","Flat","0","","","","0","1","1","","0","","","","2024-11-27 17:52:19","2024-11-27 17:52:19");
INSERT INTO sales VALUES("71","sr-20241128-102312","1","3","","","1","1","1","1","1","0","0","577","577","","","0","0","Flat","0","","","","0","1","1","","","","","","2024-11-28 22:23:12","2024-11-28 22:23:12");
INSERT INTO sales VALUES("72","sr-20241128-102653","1","3","","","1","1","1","1","1","0","0","577","577","","","0","0","Flat","0","","","","0","1","1","","0","","","","2024-11-28 22:26:53","2024-11-28 22:26:53");
INSERT INTO sales VALUES("73","posr-20241203-010211","1","3","","","2","1","1","1","1","0","95.45","1050","1050","1","1","0","0","Flat","","0","","0","0","1","4","","1050","","","","2024-12-03 13:02:11","2024-12-03 13:02:11");
INSERT INTO sales VALUES("74","posr-20241203-021016","1","3","","","2","1","1","1","1","0","95.45","1050","1050","1","1","0","0","Flat","","0","","0","0","1","2","","0","","","","2024-12-03 14:10:16","2024-12-03 14:10:16");
INSERT INTO sales VALUES("75","posr-20241203-021223","1","3","","","2","1","1","1","1","0","95.45","1050","1050","1","1","0","0","Flat","","0","","0","0","1","2","","0","","","","2024-12-03 14:12:23","2024-12-03 14:12:23");
INSERT INTO sales VALUES("76","posr-20241203-021244","1","3","","","2","1","1","1","1","0","95.45","1050","1050","1","1","0","0","Flat","","0","","0","0","1","2","","550","","","","2024-12-03 14:12:44","2024-12-03 14:12:44");
INSERT INTO sales VALUES("77","posr-20241203-021927","1","3","","","2","1","1","1","1","0","95.45","1050","1050","1","1","0","0","Flat","","0","","0","0","1","2","","500","","","","2024-12-03 14:19:27","2024-12-03 14:19:27");
INSERT INTO sales VALUES("78","posr-20241203-021951","1","3","","","2","1","1","1","1","0","95.45","1050","1050","1","1","0","0","Flat","","0","","0","0","1","2","","550","","","","2024-12-03 14:19:51","2024-12-03 14:19:51");
INSERT INTO sales VALUES("79","posr-20241203-022009","1","3","","","2","1","1","1","1","0","95.45","1050","1050","1","1","0","0","Flat","","0","","0","0","1","2","","550","","","","2024-12-03 14:20:09","2024-12-03 14:20:09");
INSERT INTO sales VALUES("80","posr-20241203-022958","1","3","","","2","1","1","1","1","0","95.45","1050","1050","1","1","0","0","Flat","","0","","0","0","1","4","","1050","","","","2024-12-03 14:29:58","2024-12-03 14:29:58");
INSERT INTO sales VALUES("81","posr-20241203-023529","1","3","","","2","1","1","1","1","0","95.45","1050","1050","1","1","0","0","Flat","","0","","0","0","1","4","","1050","","","","2024-12-03 14:35:29","2024-12-03 14:35:29");
INSERT INTO sales VALUES("82","posr-20241203-023727","1","3","","","2","1","1","1","1","0","95.45","1050","1050","1","1","0","0","Flat","","0","","0","0","1","4","","1050","","","","2024-12-03 14:37:27","2024-12-03 14:37:27");
INSERT INTO sales VALUES("83","posr-20241203-024006","1","3","","","2","1","1","1","1","0","95.45","1050","1050","1","1","0","0","Flat","","0","","0","0","1","2","","0","","","","2024-12-03 14:40:06","2024-12-03 14:40:06");
INSERT INTO sales VALUES("84","posr-20241203-024509","1","3","","","2","1","1","1","1","0","95.45","1050","1050","1","1","0","0","Flat","","0","","0","0","1","2","","500","","","","2024-12-03 14:45:09","2024-12-03 14:45:09");
INSERT INTO sales VALUES("85","posr-20241203-033707","1","3","","","2","1","1","1","1","0","95.45","1050","1050","1","1","0","0","Flat","","0","","0","0","1","4","","1050","","","","2024-12-03 15:37:07","2024-12-03 15:37:07");
INSERT INTO sales VALUES("86","posr-20241203-033802","1","3","","","2","1","1","1","1","0","95.45","1050","1050","1","1","0","0","Flat","","0","","0","0","1","4","","1050","","","","2024-12-03 15:38:02","2024-12-03 15:38:02");
INSERT INTO sales VALUES("87","posr-20241203-034048","1","3","","","2","1","1","1","1","0","95.45","1050","1050","1","1","0","0","Flat","","0","","0","0","1","4","","1050","","","","2024-12-03 15:40:48","2024-12-03 15:40:48");
INSERT INTO sales VALUES("88","posr-20241203-061213","1","3","","","2","1","1","1","1","0","95.45","1050","1050","1","1","0","0","Flat","","0","","0","0","1","2","","100","","","","2024-12-03 18:12:13","2024-12-03 18:12:13");
INSERT INTO sales VALUES("89","posr-20241203-061342","1","3","","","2","1","1","1","1","0","95.45","1050","1050","1","1","0","0","Flat","","0","","0","0","1","4","","1050","","","","2024-12-03 18:13:42","2024-12-03 18:13:42");
INSERT INTO sales VALUES("90","posr-20241203-061505","1","3","","","2","1","1","1","1","0","95.45","1050","1050","1","1","0","0","Flat","","0","","0","0","1","4","","1050","","","","2024-12-03 18:15:05","2024-12-03 18:15:05");
INSERT INTO sales VALUES("91","posr-20241203-061907","1","3","","","2","1","1","1","1","0","95.45","1050","1050","1","1","0","0","Flat","","0","","0","0","1","2","","1050","","","","2024-12-03 18:19:07","2024-12-03 18:19:07");
INSERT INTO sales VALUES("92","posr-20241203-061957","1","3","","","2","1","1","1","1","0","95.45","1050","1050","1","1","0","0","Flat","","0","","0","0","1","2","","1050","","","","2024-12-03 18:19:57","2024-12-03 18:19:57");
INSERT INTO sales VALUES("93","posr-20241204-043022","1","3","","","2","1","1","1","1","0","95.45","1050","1050","1","1","0","0","Flat","","0","","0","0","1","2","","1050","","","","2024-12-04 16:30:22","2024-12-04 16:30:22");
INSERT INTO sales VALUES("94","posr-20241204-043903","1","3","","","2","1","1","1","1","0","95.45","1050","1050","1","1","0","0","Flat","","0","","0","0","1","2","","1050","","","","2024-12-04 16:39:03","2024-12-04 16:39:03");
INSERT INTO sales VALUES("95","posr-20241204-044129","1","3","","","2","1","1","1","1","0","95.45","1050","1050","1","1","0","0","Flat","","0","","0","0","1","2","","1050","","","","2024-12-04 16:41:29","2024-12-04 16:41:29");
INSERT INTO sales VALUES("96","posr-20241204-044157","1","3","","","2","1","1","1","1","0","95.45","1050","1050","1","1","0","0","Flat","","0","","0","0","1","4","","1050","","","","2024-12-04 16:41:57","2024-12-04 16:41:57");
INSERT INTO sales VALUES("97","posr-20241204-045422","1","3","","","2","1","1","1","1","0","95.45","1050","1050","1","1","0","0","Flat","","0","","0","0","1","4","","1050","","","","2024-12-04 16:54:22","2024-12-04 16:54:22");
INSERT INTO sales VALUES("98","posr-20241204-045637","1","3","","","2","1","1","1","1","0","95.45","1050","1050","1","1","0","0","Flat","","0","","0","0","1","4","","1050","","","","2024-12-04 16:56:37","2024-12-04 16:56:37");
INSERT INTO sales VALUES("99","posr-20241204-045728","1","3","","","2","1","1","1","1","0","95.45","1050","1050","1","1","","0","Flat","","0","","0","0","1","4","","1050","","","","2024-12-04 16:57:28","2024-12-04 16:57:28");
INSERT INTO sales VALUES("100","posr-20241204-045751","1","3","","","2","1","1","1","1","0","95.45","1050","1050","1","1","","0","Flat","","0","","0","0","1","4","","1050","","","","2024-12-04 16:57:51","2024-12-04 16:57:51");
INSERT INTO sales VALUES("101","posr-20241204-055835","1","3","","","2","1","1","1","1","0","95.45","1050","1050","1","1","","0","Flat","","0","","0","0","1","4","","1050","","","","2024-12-04 17:58:35","2024-12-04 17:58:35");
INSERT INTO sales VALUES("102","posr-20241204-055915","1","3","","","2","1","1","1","1","0","95.45","1050","1050","1","1","0","0","Flat","","0","","0","0","1","4","","1050","","","","2024-12-04 17:59:15","2024-12-04 17:59:15");
INSERT INTO sales VALUES("103","posr-20241204-060435","1","3","","","2","1","1","1","1","0","95.45","1050","1050","1","1","0","0","Flat","","0","","0","0","1","4","","1050","","","","2024-12-04 18:04:35","2024-12-04 18:04:35");
INSERT INTO sales VALUES("104","posr-20241204-060520","1","3","","","2","1","1","1","1","0","95.45","1050","1050","1","1","0","0","Flat","","0","","0","0","1","4","","1050","","","","2024-12-04 18:05:20","2024-12-04 18:05:20");
INSERT INTO sales VALUES("105","posr-20241204-060542","1","3","","","2","1","1","1","1","0","95.45","1050","1050","1","1","0","0","Flat","","0","","0","0","1","4","","1050","","","","2024-12-04 18:05:42","2024-12-04 18:05:42");
INSERT INTO sales VALUES("106","posr-20241204-060607","1","3","","","2","1","1","1","1","0","95.45","1050","1050","1","1","0","0","Flat","","0","","0","0","1","4","","1050","","","","2024-12-04 18:06:07","2024-12-17 10:20:51");
INSERT INTO sales VALUES("107","posr-20241204-060852","1","3","","","2","1","1","1","1","0","95.45","1050","1050","1","1","0","0","Flat","","0","","0","0","1","4","","1050","","","","2024-12-04 18:08:52","2024-12-04 18:08:52");
INSERT INTO sales VALUES("108","sr-20241206-120019","1","3","","","1","1","1","1","1","0","0","577","577","1","1","0","0","Flat","","0","","","0","1","4","","577","","","","2024-12-06 12:00:19","2024-12-06 12:00:19");
INSERT INTO sales VALUES("109","sr-20241206-121740","1","3","","","2","1","1","1","1","0","0","577","577","1","1","0","0","Flat","","0","","","0","1","4","","577","","","","2024-12-06 12:17:40","2024-12-06 12:17:40");
INSERT INTO sales VALUES("110","sr-20241207-124003","1","3","","","1","1","1","1","1","0","0","577","577","1","1","0","0","Flat","","0","","","0","1","4","","577","","","","2024-12-07 12:40:03","2024-12-07 12:40:03");
INSERT INTO sales VALUES("111","sr-20241208-112955","1","3","","","1","1","1","1","1","0","0","577","577","1","1","0","0","Flat","","0","","","0","1","4","","577","","","","2024-12-08 11:29:55","2024-12-08 11:29:55");
INSERT INTO sales VALUES("112","posr-20241217-102418","1","3","","","2","1","1","1","1","0","118.18","1299.99","1199.99","1","1","0","0","Flat","100","100","","0","0","1","4","","1199.99","","","","2024-12-17 10:24:18","2024-12-17 10:25:23");
INSERT INTO sales VALUES("113","posr-20241217-102631","1","3","","","2","1","1","1","1","0","0","1.29","1.29","1","1","0","0","Flat","","0","","0","0","1","4","","1.29","","","","2024-12-17 10:26:31","2024-12-17 10:27:08");
INSERT INTO sales VALUES("114","posr-20241218-111745","1","3","","","2","1","1","1","1","0","85.91","945","945","1","1","0","0","Flat","","0","","0","0","1","4","","945","","","","2024-12-18 11:17:45","2024-12-18 11:17:45");
INSERT INTO sales VALUES("115","sr-20241219-113108","1","3","","","2","1","1","1","1","0","0","810","810","1","1","0","0","Flat","","0","","","0","1","1","","0","","","","2024-12-19 11:31:08","2024-12-19 11:31:08");
INSERT INTO sales VALUES("116","sr-20241219-114303","1","3","","","1","1","1","1","1","0","0","27","27","1","1","0","0","Flat","","0","","","0","1","4","","27","","","","2024-12-19 11:43:03","2024-12-19 11:44:02");
INSERT INTO sales VALUES("118","posr-20241223-121043","9","4","","","2","1","1","1","1","0","106.36","1169.99","1169.99","1","1","","0","","","0","","0","0","1","4","","1169.99","","","","2024-12-23 12:10:43","2024-12-23 12:10:43");
INSERT INTO sales VALUES("119","sr-20241229-122648","1","3","","","4","1","1","1","1","0","0","577","577","1","1","0","0","Flat","","0","","","0","1","4","","577","","","","2024-12-29 00:26:48","2024-12-29 00:26:48");
INSERT INTO sales VALUES("120","posr-20241229-123534","1","3","","","2","1","1","1","1","0","106.36","1169.99","1169.99","1","1","0","0","Flat","","0","","0","0","1","4","","1169.99","","","","2024-12-29 12:35:34","2024-12-29 12:35:34");
INSERT INTO sales VALUES("121","posr-20241229-123947","1","3","","","2","1","1","1","1","0","106.36","1169.99","1169.99","1","1","0","0","Flat","","0","","0","0","1","4","","1169.99","","","","2024-12-29 12:39:47","2024-12-29 12:39:47");
INSERT INTO sales VALUES("122","posr-20241229-124002","1","3","","","2","1","1","1","1","0","85.91","945","945","1","1","0","0","Flat","","0","","0","0","1","4","","945","","","","2024-12-29 12:40:02","2024-12-29 12:40:02");
INSERT INTO sales VALUES("123","posr-20241229-124414","1","3","","","2","1","1","1","1","0","106.36","1169.99","1169.99","1","1","0","0","Flat","","0","","0","0","1","4","","1169.99","","","","2024-12-29 12:44:14","2024-12-29 12:44:14");
INSERT INTO sales VALUES("124","posr-20241229-124536","1","3","","","2","1","1","1","1","0","106.36","1169.99","1169.99","1","1","0","0","Flat","","0","","0","0","1","4","","1169.99","","","","2024-12-29 12:45:36","2024-12-29 12:45:36");
INSERT INTO sales VALUES("125","posr-20241229-010600","1","3","","","2","1","1","1","1","0","106.36","1169.99","1169.99","1","1","0","0","Flat","","0","","0","0","1","4","","1169.99","","","","2024-12-29 13:06:00","2024-12-29 13:06:00");
INSERT INTO sales VALUES("126","posr-20241229-010827","1","3","","","2","1","1","1","1","0","106.36","1169.99","1169.99","1","1","0","0","Flat","","0","","0","0","1","4","","1169.99","","","","2024-12-29 13:08:27","2024-12-29 13:08:27");
INSERT INTO sales VALUES("127","posr-20241229-010944","1","3","","","2","1","1","1","1","0","106.36","1169.99","1169.99","1","1","0","0","Flat","","0","","0","0","1","4","","1169.99","","","","2024-12-29 13:09:44","2024-12-29 13:09:44");
INSERT INTO sales VALUES("128","posr-20241229-011046","1","3","","","2","1","1","1","1","0","106.36","1169.99","1169.99","1","1","0","0","Flat","","0","","0","0","1","4","","1169.99","","","","2024-12-29 13:10:46","2024-12-29 13:10:46");
INSERT INTO sales VALUES("129","posr-20241229-020303","1","3","","","2","1","1","1","1","0","106.36","1169.99","1169.99","1","1","0","0","Flat","","0","","0","0","1","4","","1169.99","","","","2024-12-29 14:03:03","2024-12-29 14:03:03");
INSERT INTO sales VALUES("130","posr-20241229-024244","1","3","","","2","1","1","1","1","0","106.36","1169.99","1169.99","1","1","0","0","Flat","","0","","0","0","1","4","","1169.99","","","","2024-12-29 14:42:44","2024-12-29 14:42:44");
INSERT INTO sales VALUES("131","posr-20241229-035114","1","3","","","2","1","1","1","1","0","106.36","1169.99","1169.99","1","1","0","0","Flat","","0","","0","0","1","4","","1169.99","","","","2024-12-29 15:51:14","2024-12-29 15:51:14");
INSERT INTO sales VALUES("132","posr-20241229-054802","1","3","","","2","1","1","1","1","0","106.36","1169.99","1169.99","1","1","0","0","Flat","","0","","0","0","1","1","","1169.99","","","","2024-12-29 17:48:02","2024-12-29 17:48:05");
INSERT INTO sales VALUES("133","posr-20241229-055021","1","3","","","2","1","1","1","1","0","106.36","1169.99","1169.99","1","1","0","0","Flat","","0","","0","0","1","4","","1169.99","","","","2024-12-29 17:50:21","2024-12-29 17:50:21");
INSERT INTO sales VALUES("134","posr-20241230-122822","1","3","","","2","1","1","1","1","0","106.36","1169.99","1169.99","1","1","0","0","Flat","","0","","0","0","1","4","","1169.99","","","","2024-12-30 12:28:22","2024-12-30 12:28:22");
INSERT INTO sales VALUES("135","posr-20241230-122946","1","3","","","2","1","1","1","1","0","106.36","1169.99","1169.99","1","1","0","0","Flat","","0","","0","0","1","4","","1169.99","","","","2024-12-30 12:29:46","2024-12-30 12:29:46");
INSERT INTO sales VALUES("136","posr-20241230-123058","1","3","","","2","1","1","1","1","0","106.36","1169.99","1169.99","1","1","0","0","Flat","","0","","0","0","1","4","","1169.99","","","","2024-12-30 12:30:58","2024-12-30 12:30:58");
INSERT INTO sales VALUES("137","posr-20241230-123131","1","3","","","2","1","1","1","1","0","106.36","1169.99","1169.99","1","1","0","0","Flat","","0","","0","0","1","4","","1169.99","","","","2024-12-30 12:31:31","2024-12-30 12:31:31");
INSERT INTO sales VALUES("138","posr-20250101-125049","1","3","","","2","1","1","1","1","0","118.18","1299.99","1299.99","1","1","0","0","Flat","","0","","0","0","1","4","","1299.99","","","","2025-01-01 12:50:49","2025-01-01 12:50:49");
INSERT INTO sales VALUES("139","posr-20250101-023752","1","3","","","2","1","1","1","1","0","118.18","1299.99","1299.99","1","1","0","0","Flat","","0","","0","0","1","4","","1299.99","","","","2025-01-01 14:37:52","2025-01-01 14:37:52");
INSERT INTO sales VALUES("141","posr-20250112-121632","1","3","","","2","1","1","1","1","0","0","577","577","1","1","0","0","Flat","","0","","0","0","1","4","","577","","","","2025-01-12 12:16:32","2025-01-12 12:16:32");
INSERT INTO sales VALUES("142","posr-20250112-121904","1","3","","","2","1","1","1","1","0","0","1.29","1.29","1","1","0","0","Flat","","0","","0","0","1","4","","1.29","","","","2025-01-12 12:19:04","2025-01-12 12:19:04");
INSERT INTO sales VALUES("143","posr-20250112-121956","1","3","","","2","1","1","1","1","0","0","577","577","1","1","0","0","Flat","","0","","0","0","1","4","","577","","","","2025-01-12 12:19:56","2025-01-12 12:19:56");
INSERT INTO sales VALUES("144","posr-20250112-122210","1","3","","","2","1","1","1","1","0","0","100","100","1","1","0","0","Flat","","0","","0","0","1","4","","100","","","","2025-01-12 12:22:10","2025-01-12 12:22:10");
INSERT INTO sales VALUES("145","posr-20250112-122339","1","3","","","2","1","1","1","1","0","0","100","100","1","1","0","0","Flat","","0","","0","0","1","4","","100","","","","2025-01-12 12:23:39","2025-01-12 12:23:39");
INSERT INTO sales VALUES("146","posr-20250112-122538","9","4","","","2","1","1","1","1","0","0","100","100","1","1","0","0","Flat","","0","","0","0","1","4","","100","","","","2025-01-12 12:25:38","2025-01-12 12:25:38");
INSERT INTO sales VALUES("147","posr-20250112-010845","1","3","","","2","1","2","1","1","0","0","100","100","1","1","0","0","Flat","","0","","0","0","1","4","","100","","","","2025-01-12 13:08:45","2025-01-12 13:08:45");
INSERT INTO sales VALUES("148","posr-20250112-014034","1","3","","","2","1","1","1","2","0","0","200","200","1","1","0","0","Flat","","0","","0","0","1","4","","200","","","","2025-01-12 13:40:34","2025-01-12 13:40:34");
INSERT INTO sales VALUES("158","posr-20250112-050624","1","3","","","2","1","1","1","1","0","0","100","100","1","1","0","0","Flat","","0","","0","0","1","4","","100","","","","2025-01-12 17:06:24","2025-01-12 17:06:24");
INSERT INTO sales VALUES("159","posr-20250112-054601","1","3","","","2","1","1","1","1","0","0","100","100","1","1","0","0","Flat","","0","","0","0","1","4","","100","","","","2025-01-12 17:46:01","2025-01-12 17:46:01");
INSERT INTO sales VALUES("160","posr-20250113-035657","1","3","","","2","1","1","2","3","0","0","300","300","1","1","0","0","Flat","","0","","0","0","1","4","","300","","","","2025-01-13 15:56:57","2025-01-13 15:56:57");
INSERT INTO sales VALUES("161","posr-20250113-035944","1","3","","","2","1","1","2","3","0","0","300","300","1","1","0","0","Flat","","0","","0","0","1","4","","300","","","","2025-01-13 15:59:44","2025-01-13 15:59:44");
INSERT INTO sales VALUES("162","posr-20250113-040000","1","3","","","2","1","1","2","3","0","0","300","300","1","1","0","0","Flat","","0","","0","0","1","4","","300","","","","2025-01-13 16:00:00","2025-01-13 16:00:00");
INSERT INTO sales VALUES("163","posr-20250114-020657","1","3","","","2","1","1","1","2","0","0","200","200","1","1","0","0","Flat","","0","","0","0","1","4","","200","","","","2025-01-14 14:06:57","2025-01-14 14:06:57");
INSERT INTO sales VALUES("166","posr-20250115-100132","1","3","","","2","1","1","1","1","0","0","100","100","1","1","0","0","Flat","","0","","0","0","1","4","","100","","","","2025-01-15 10:01:32","2025-01-15 10:01:32");
INSERT INTO sales VALUES("168","posr-20250115-124611","1","3","","","2","1","1","1","1","0","0","100","100","1","1","0","0","Flat","","0","","0","0","1","4","","100","","","","2025-01-15 12:46:11","2025-01-15 12:46:11");
INSERT INTO sales VALUES("172","posr-20250115-035841","1","3","","","2","1","1","1","2","0","0","20","20","1","1","0","0","Flat","","0","","0","0","1","4","","20","","","","2025-01-15 15:58:41","2025-01-15 15:58:41");
INSERT INTO sales VALUES("173","posr-20250119-051138","1","3","","","2","1","1","1","1","0","0","100","100","1","1","0","0","Flat","","0","","0","0","1","4","","100","","","","2025-01-19 17:11:38","2025-01-19 17:11:38");
INSERT INTO sales VALUES("174","posr-20250119-051831","1","3","","","2","1","1","1","1","0","0","100","100","1","1","0","0","Flat","","0","","0","0","1","4","","100","","","","2025-01-19 17:18:31","2025-01-19 17:18:31");
INSERT INTO sales VALUES("190","posr-20250121-104500","1","3","","","2","1","1","1","1","0","0","100","100","1","1","0","0","Flat","","0","","0","0","1","4","","100","","","","2025-01-21 10:45:00","2025-01-21 10:45:00");
INSERT INTO sales VALUES("191","posr-20250121-021716","1","3","","","2","1","1","3","3","0","10","310","310","1","1","0","0","Flat","","0","","0","0","1","4","","310","","","","2025-01-21 14:17:16","2025-01-21 14:17:16");
INSERT INTO sales VALUES("194","posr-20250126-113536","1","3","","","2","1","1","1","1","0","0","100","100","1","1","0","0","Flat","","0","","0","0","1","4","","100","","","","2025-01-26 23:35:36","2025-01-26 23:35:36");
INSERT INTO sales VALUES("195","posr-20250127-092630","1","3","","","2","1","1","1","1","0","0","100","100","1","1","0","0","Flat","","0","","0","0","3","2","","0","","","","2025-01-27 09:26:30","2025-01-27 09:26:30");
INSERT INTO sales VALUES("196","posr-20250127-092842","1","3","","","2","1","1","1","1","0","0","1111.99","1111.99","1","1","0","0","Flat","","0","","0","0","3","2","","0","","","","2025-01-27 09:28:42","2025-01-27 09:28:42");



CREATE TABLE `sms_templates` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `is_default_ecommerce` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO sms_templates VALUES("1","test template","eso nije kori...","1","0","2024-05-19 14:14:12","2024-10-29 02:07:53");
INSERT INTO sms_templates VALUES("2","test template 2","fsdfsdf","0","1","2024-05-19 14:20:25","2024-10-29 02:07:53");



CREATE TABLE `stock_counts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `warehouse_id` int NOT NULL,
  `category_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `brand_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int NOT NULL,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `initial_file` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `final_file` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `is_adjusted` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO stock_counts VALUES("1","scr-20240825-060302","1","","","1","full","20240825-060302.csv","","","0","2024-08-26 05:03:02","2024-08-26 05:03:02");



CREATE TABLE `suppliers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `vat_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postal_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO suppliers VALUES("1","Abdullah","","Global Tech","31213131","abdullah@gmail.com","312313","Mirpur","Dhaka","","","Bangladesh","1","2024-01-19 19:41:37","2024-01-19 19:41:37");
INSERT INTO suppliers VALUES("2","rahmatullah","","Samsung","","info@microsoft.com","213123123","boropul, halishahr","chittagong","","","","1","2024-07-18 13:51:07","2024-07-18 13:51:07");
INSERT INTO suppliers VALUES("3","Brian James","WillisandHardinPlc.png","Willis and Hardin Plc","548","vadaqyteka@mailinator.com","+1 (737) 222-6586","Laboris est libero d","Sit nostrud obcaeca","Consectetur sint q","Veniam doloribus de","Assumenda dolor atqu","0","2025-01-23 14:31:22","2025-01-23 14:31:47");



CREATE TABLE `tables` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `number_of_person` int DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `floor_id` tinyint NOT NULL DEFAULT '1',
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tables VALUES("1","Table 1","3","middle table","1","1","2024-04-21 10:58:24","2024-04-21 10:58:24");



CREATE TABLE `taxes` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `rate` double NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `woocommerce_tax_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO taxes VALUES("1","@10","10","1","","2024-01-08 11:26:16","2024-01-08 11:26:16");
INSERT INTO taxes VALUES("2","@15","15","1","","2024-01-08 11:26:29","2024-01-08 11:26:29");
INSERT INTO taxes VALUES("3","vat 20%","20","1","","2024-04-29 18:28:49","2024-04-29 18:28:49");



CREATE TABLE `transfers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int NOT NULL,
  `status` int NOT NULL,
  `from_warehouse_id` int NOT NULL,
  `to_warehouse_id` int NOT NULL,
  `item` int NOT NULL,
  `total_qty` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_cost` double NOT NULL,
  `shipping_cost` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `document` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `is_sent` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO transfers VALUES("11","tr-20240528-030550","1","1","1","2","1","1","0","439","","439","","","1","2024-05-28 15:05:50","2024-05-28 15:05:56");
INSERT INTO transfers VALUES("12","tr-20240528-030714","1","1","1","2","1","1","0","399","","399","","","1","2024-05-28 15:07:14","2024-05-28 15:07:20");
INSERT INTO transfers VALUES("13","tr-20241124-031128","1","1","1","2","1","1","0","100","","100","","","0","2024-11-24 15:11:28","2024-11-24 15:11:28");
INSERT INTO transfers VALUES("14","tr-20250121-025702","1","1","1","2","1","2","0","20","","20","","","0","2025-01-21 14:57:02","2025-01-21 14:57:02");
INSERT INTO transfers VALUES("15","tr-20250122-114218","1","1","2","1","1","2","0","20","","20","","","0","2025-01-22 11:42:18","2025-01-22 11:42:18");



CREATE TABLE `units` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `unit_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `base_unit` int DEFAULT NULL,
  `operator` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `operation_value` double DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO units VALUES("1","pc","Piece","","*","1","1","2024-01-08 11:37:39","2024-01-08 11:37:39");
INSERT INTO units VALUES("2","dozen","Dozen","1","*","12","1","2024-01-08 11:38:27","2024-01-08 11:38:27");
INSERT INTO units VALUES("3","carton","Carton","1","*","24","1","2024-01-08 11:39:01","2024-01-08 11:39:01");
INSERT INTO units VALUES("4","kg","Kilogram","","*","1","1","2024-01-08 11:39:37","2024-01-08 11:39:37");
INSERT INTO units VALUES("5","gm","Gram","4","/","1000","1","2024-01-08 11:40:00","2024-01-08 11:40:00");



CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role_id` int NOT NULL,
  `biller_id` int DEFAULT NULL,
  `warehouse_id` int DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO users VALUES("1","admin","ashfaqdev.php@gmail.com","$2y$10$D3NNYjFpxZ/7ve5fTVs.k.6cH5AfPyPC1JL7/G8NQoVcTPvt9nZoa","Rgu7rFUpMEPGlEon6i7B6m7OHAtbFmt4hRj0fRfLtJ3FLNJgTHjJxQiRcPkp","12112","lioncoders","1","","","1","0","2018-06-02 09:24:15","2023-07-15 17:18:25");
INSERT INTO users VALUES("3","dhiman da","dhiman@gmail.com","$2y$10$Fef6vu5E67nm11hX7V5a2u1ThNCQ6n9DRCvRF9TD7stk.Pmt2R6O.","5ehQM6JIfiQfROgTbB5let0Z93vjLHS7rd9QD5RPNgOxli3xdo7fykU7vtTt","212","lioncoders","1","","","0","1","2018-06-14 04:00:31","2020-11-05 13:06:51");
INSERT INTO users VALUES("6","test","test@gmail.com","$2y$10$TDAeHcVqHyCmurki0wjLZeIl1SngKX3WLOhyTiCoZG3souQfqv.LS","KpW1gYYlOFacumklO2IcRfSsbC3KcWUZzOI37gqoqM388Xie6KdhaOHIFEYm","1234","212312","4","","","0","1","2018-06-23 09:05:33","2018-06-23 09:13:45");
INSERT INTO users VALUES("8","test","test@yahoo.com","$2y$10$hlMigidZV0j2/IPkgE/xsOSb8WM2IRlsMv.1hg1NM7kfyd6bGX3hC","","31231","","4","","","0","1","2018-06-25 04:35:49","2018-07-02 07:07:39");
INSERT INTO users VALUES("9","staff","anda@gmail.com","$2y$10$kxDbnynB6mB1e1w3pmtbSOlSxy/WwbLPY5TJpMi0Opao5ezfuQjQm","FfJGHOJqiBCUbRdXoMV4TA1513siTPHM6yDDkfwjPMncMj6dirnCh9MQP2pM","3123","","4","1","1","1","0","2018-07-02 07:08:08","2018-10-24 03:41:13");
INSERT INTO users VALUES("10","abul","abul@alpha.com","$2y$10$5zgB2OOMyNBNVAd.QOQIju5a9fhNnTqPx5H6s4oFlXhNiF6kXEsPq","x7HlttI5bM0vSKViqATaowHFJkLS3PHwfvl7iJdFl5Z1SsyUgWCVbLSgAoi0","1234","anda","1","","","0","0","2018-09-08 05:44:48","2018-09-08 05:44:48");
INSERT INTO users VALUES("11","teststaff","a@a.com","$2y$10$5KNBIIhZzvvZEQEhkHaZGu.Q8bbQNfqYvYgL5N55B8Pb4P5P/b/Li","DkHDEcCA0QLfsKPkUK0ckL0CPM6dPiJytNa0k952gyTbeAyMthW3vi7IRitp","111","aa","4","5","1","0","1","2018-10-22 08:47:56","2018-10-23 08:10:56");
INSERT INTO users VALUES("12","john","john@gmail.com","$2y$10$P/pN2J/uyTYNzQy2kRqWwuSv7P2f6GE/ykBwtHdda7yci3XsfOKWe","O0f1WJBVjT5eKYl3Js5l1ixMMtoU6kqrH7hbHDx9I1UCcD9CmiSmCBzHbQZg","10001","","4","2","2","0","1","2018-12-30 06:48:37","2019-03-06 10:59:49");
INSERT INTO users VALUES("13","jjj","test@test.com","$2y$10$/Qx3gHWYWUhlF1aPfzXaCeZA7fRzfSEyCIOnk/dcC4ejO8PsoaalG","","1213","","1","","","0","1","2019-01-03 06:08:31","2019-03-03 10:02:29");
INSERT INTO users VALUES("19","shakalaka","shakalaka@gmail.com","$2y$10$ketLWT0Ib/JXpo00eJlxoeSw.7leS8V1CUGInfbyOWT4F5.Xuo7S2","","1212","Digital image","5","","","1","0","2020-11-09 06:07:16","2020-11-09 06:07:16");
INSERT INTO users VALUES("21","modon","modon@gmail.com","$2y$10$7VpoeGMkP8QCvL5zLwFW..6MYJ5MRumDLDoX.TTQtClS561rpFHY.","","2222","modon company","5","","","1","0","2020-11-13 13:12:08","2020-11-13 13:12:08");
INSERT INTO users VALUES("22","dhiman","dhiman@gmail.com","$2y$10$3mPygsC6wwnDtw/Sg85IpuExtUhgaHx52Lwp7Rz0.FNfuFdfKVpRq","","+8801111111101","lioncoders","5","","","1","0","2020-11-15 12:14:58","2020-11-15 12:14:58");
INSERT INTO users VALUES("31","mbs","mbs@gmail.com","$2y$10$6Ldm1rWEVSrlTmpjIXkeQO9KwWJz/j0FB4U.fY1oCFeax47rvttEK","","2121","","4","1","2","0","0","2021-12-29 12:40:22","2021-12-29 12:40:22");
INSERT INTO users VALUES("39","maja","maja@maja.com","$2y$10$lrMVhNDE9AuKhFrJIgG2y.zdtrCltR8/JB1okO0W8GsUcMjSFW7rW","","444555","","4","5","2","1","0","2022-09-14 10:37:21","2022-09-14 10:37:21");
INSERT INTO users VALUES("42","Tarik Iqbal","tarik_17@yahoo.co.uk","$2y$10$z2nZAsrIPrSWgPEtTY9D6.1vmkvYj4p3W3kamYvdoCDnCtlVqZp86","","","","5","","","1","0","2023-11-17 11:04:37","2023-11-28 21:10:11");
INSERT INTO users VALUES("43","support@lion-coders.com","support@lion-coders.com","$2y$10$ea.ekPLTQk0Y5087FqSbdevaN.gkEMGucgFJ13aGPEd.EqY45Y.AK","","","","5","","","1","0","2023-12-09 20:15:06","2023-12-09 20:15:50");
INSERT INTO users VALUES("44","james","jamesbond@gmail.com","$2y$10$7XCviP5GAZm6E/nlk4HQmuyw2kbhVpLbxsN6PqmNubmUKpiseGiEy","","313131","MI6","5","","","1","0","2024-01-19 19:23:28","2024-01-19 19:23:28");
INSERT INTO users VALUES("46","bkk","bkk@bkk.com","$2y$10$6FBCW.gf7tOH6ygDYLUcSeVkur1VL.iBSvGor35AxO849fJLxxZoW","","87897","","5","","","1","0","2024-06-10 16:40:15","2024-06-10 16:40:15");



CREATE TABLE `variants` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO variants VALUES("1","s/red","2024-11-24 14:57:18","2024-11-24 14:57:18");
INSERT INTO variants VALUES("2","s/blue","2024-11-24 14:57:18","2024-11-24 14:57:18");
INSERT INTO variants VALUES("3","m/red","2024-11-24 14:57:18","2024-11-24 14:57:18");
INSERT INTO variants VALUES("4","m/blue","2024-11-24 14:57:18","2024-11-24 14:57:18");
INSERT INTO variants VALUES("5","red","2024-12-19 11:23:34","2024-12-19 11:23:34");
INSERT INTO variants VALUES("6","green","2024-12-19 11:23:34","2024-12-19 11:23:34");
INSERT INTO variants VALUES("7","blue","2024-12-19 11:23:34","2024-12-19 11:23:34");
INSERT INTO variants VALUES("8","Black/Blue","2025-01-08 14:43:52","2025-01-08 14:43:52");
INSERT INTO variants VALUES("9","White","2025-01-08 15:08:46","2025-01-08 15:08:46");
INSERT INTO variants VALUES("10","Silver","2025-01-08 18:50:34","2025-01-08 18:50:34");
INSERT INTO variants VALUES("11","Black","2025-01-08 18:50:34","2025-01-08 18:50:34");
INSERT INTO variants VALUES("12","Sky","2025-01-08 18:56:54","2025-01-08 18:56:54");
INSERT INTO variants VALUES("13","Inherit","2025-01-08 18:56:54","2025-01-08 18:56:54");
INSERT INTO variants VALUES("14","Ash","2025-01-09 10:32:16","2025-01-09 10:32:16");
INSERT INTO variants VALUES("15","Brown","2025-01-20 10:53:13","2025-01-20 10:53:13");
INSERT INTO variants VALUES("16","S/Green","2025-01-22 16:01:22","2025-01-22 16:01:22");
INSERT INTO variants VALUES("17","M/Green","2025-01-22 16:01:22","2025-01-22 16:01:22");
INSERT INTO variants VALUES("18","L/Red","2025-01-22 16:01:22","2025-01-22 16:01:22");
INSERT INTO variants VALUES("19","L/Green","2025-01-22 16:01:22","2025-01-22 16:01:22");



CREATE TABLE `warehouses` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO warehouses VALUES("1","Shop 1","97090998","ashfaqdev.php@gmail.com","london","1","2024-01-19 19:28:31","2024-05-28 13:56:14");
INSERT INTO warehouses VALUES("2","Shop 2","8098098","ashfaqdev.php@gmail.com","Liverpool","1","2024-01-19 19:28:52","2024-05-28 13:57:05");



CREATE TABLE `woocommerce_settings` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `woocomerce_app_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `woocomerce_consumer_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `woocomerce_consumer_secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_tax_class` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_tax_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `manage_stock` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stock_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_group_id` tinyint DEFAULT NULL,
  `warehouse_id` tinyint DEFAULT NULL,
  `biller_id` tinyint DEFAULT NULL,
  `order_status_pending` tinyint DEFAULT NULL,
  `order_status_processing` tinyint DEFAULT NULL,
  `order_status_on_hold` tinyint DEFAULT NULL,
  `order_status_completed` tinyint DEFAULT NULL,
  `order_status_draft` tinyint DEFAULT NULL,
  `webhook_secret_order_created` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `webhook_secret_order_updated` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `webhook_secret_order_deleted` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `webhook_secret_order_restored` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `woocommerce_sync_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `sync_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `operation` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `records` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `synced_by` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


