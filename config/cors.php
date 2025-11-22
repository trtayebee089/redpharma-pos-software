<?php

return [

    'paths' => ['api/*'], // all API routes

    'allowed_methods' => ['*'], // GET, POST, etc.

    'allowed_origins' => ['http://localhost:5173'], 

    'allowed_origins_patterns' => [],

    'allowed_headers' => ['*'],

    'exposed_headers' => [],

    'max_age' => 0,

    'supports_credentials' => false, // keep false unless you need cookies/auth
];
