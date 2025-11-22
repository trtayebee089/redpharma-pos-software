<p align="center">
  <img src="https://www.redpharmabd.com/assets/logo-DQC7WR4c.png" alt="RedPharma Logo" width="200"/>
</p>
# RedPharma POS – API & System Modifications

[![GitHub Repo](https://img.shields.io/badge/GitHub-Repo-blue?logo=github)](https://github.com/trtayebee089/redpharma-pos-software)

RedPharma POS is a comprehensive pharmacy management system for Bangladesh, integrating **point-of-sale (POS) functionality**, **online orders**, **customer reward points**, **shipping zones**, and **API endpoints** for mobile/web integration. This document outlines the modifications made to the POS system, including database changes, frontend updates, and API enhancements.

---

## Table of Contents

- [Features](#features)  
- [Database Modifications](#database-modifications)  
- [Frontend Modifications](#frontend-modifications)  
- [Controllers](#controllers)  
- [API Endpoints](#api-endpoints)  
- [Deployment Instructions](#deployment-instructions)  
- [Project Repository](#project-repository)  
- [License](#license)

---

## Features

- **SEO-friendly categories & products** using slugs  
- **Sale type tracking**: POS, website, manual entry  
- **Customer enhancements**: password, avatar, gender, card number  
- **Riders & order tracking** for deliveries  
- **Reward point system** with tiers and usage logs  
- **Shipping zones** for cost management  
- **API endpoints** for integration with web/mobile apps  
- **Enhanced backend UI** for orders, reward points, and shipping zones

---

## Database Modifications

### Categories Table
```php
$table->string('slug')->after('name')->nullable();
$table->string('bg_color')->nullable()->after('is_active');
```
- **slug**: SEO-friendly URL for category  
- **bg_color**: Background color for category display  

### Products Table
```php
$table->string('slug')->after('name')->nullable();
```
- **slug**: SEO-friendly URL for product  

### Sales Table
```php
$table->enum('sale_type', ["pos", "website", "manual"])->default("pos")->after("reference_no");
```
- **sale_type**: Identify the origin of sale  

### Customers Table
```php
$table->string('password')->nullable()->after('phone_number');
$table->string('avator')->nullable()->after('name');
$table->enum('gender', ['male','female','others'])->default('male')->after('name');
$table->string('card_number')->nullable()->after('password');
```
- **password**: Customer authentication  
- **avatar**: Customer profile picture  
- **gender**: Customer gender  
- **card_number**: Loyalty/membership card  

### New Tables

- **Riders**: Manage delivery personnel  
- **Order Trackings**: Track order statuses  
- **Reward Point Tiers**: Define points tiers  
- **Reward Point Usages**: Log points usage  
- **Shipping Zones**: Define shipping areas & costs  
- **Account Removal Requests**: Receive account delete requests  

> All new tables have corresponding Eloquent models in `app/Models`.

---

## Frontend Modifications

- **Sidebar Menu**: Added "Orders List" (`resources/views/backend/layouts/sidebar.blade.php`)  
- **Reward Points Settings**: Updated to accommodate tiers (`resources/views/backend/reward_point_setting.blade.php`)  
- **Shipping Zones**: Manage shipping costs by zone (`resources/views/backend/shipping_zones.blade.php`)  
- **Customers List**: People management (`resources/views/backend/customers.blade.php`)  

---

## Controllers

### Web Controllers
- **OnlineOrderController.php**  
- **RiderController.php**  
Purpose: Manage online orders and rider assignments.

### API Controllers
- Located in `app/Http/Controllers/API`  
- New controllers for **Riders, Orders, Reward Points, Shipping Zones**  

---

## API Endpoints

- Update categories slug:  
`https://redpharma.techrajshahi.com/api/categories/boot-slug/update`  
- Update products slug:  
`https://redpharma.techrajshahi.com/api/products/boot-slug/update`  

> Use Postman or similar tools to test all API endpoints.

---

## Deployment Instructions

1. Clone the repository:
```bash
git clone https://github.com/trtayebee089/redpharma-pos-software.git
cd redpharma-pos-software
```
2. Install dependencies:
```bash
composer install
npm install
npm run dev
```
3. Copy environment file:
```bash
cp .env.example .env
php artisan key:generate
```
4. Run database migrations:
```bash
php artisan migrate
```
5. Verify new tables and columns.  
6. Check backend accessibility of **Orders List, Reward Points, and Shipping Zones**.  
7. Update models, routes (`routes/web.php`), and language files as needed.  
8. Update sale type in `SaleController`:
```php
$sale->sale_type = 'pos';
```

---

## Project Repository

[RedPharma POS GitHub Repository](https://github.com/trtayebee089/redpharma-pos-software)

---

## License

This project is licensed under the **MIT License** – see the [LICENSE](LICENSE) file for details.

---

## Notes

- Always verify **reward point data** and **shipping zones** for consistency after deployment  
- Use the latest Laravel version recommended for POS module compatibility  
- Vendor directory should **not be committed**; use `.gitignore` to avoid LFS issues  
- For any API testing, ensure your `.env` is correctly configured with DB and API keys
