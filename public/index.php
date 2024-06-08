<?php

header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');
header('Access-Control-Allow-Origin: *');

// If the request is an OPTIONS request (pre-flight check)
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    header("HTTP/1.1 200 OK");
    exit;
}

require_once __DIR__ . '/../vendor/autoload.php';

define('BASE_PATH', dirname(__DIR__) . '/');

Dotenv\Dotenv::createImmutable(BASE_PATH)->load();

include_once BASE_PATH . 'src/helpers.php';

$dispatcher = FastRoute\simpleDispatcher(function (FastRoute\RouteCollector $r) {
    $r->post('/graphql', [App\GraphQL\Controller::class, 'handle']);
});

$routeInfo = $dispatcher->dispatch(
    $_SERVER['REQUEST_METHOD'],
    $_SERVER['REQUEST_URI']
);

switch ($routeInfo[0]) {
    case FastRoute\Dispatcher::NOT_FOUND:
        // This block of code fixes the issue where static assets (CSS, JS, images) 
        // were being served with the MIME type 'text/html' instead of their correct MIME types.
        // It checks if the requested URI matches the pattern of typical static file extensions.
        // If a match is found, it sets the appropriate MIME type header and serves the file directly.
        // This prevents the browser from misinterpreting the files and ensures they are correctly loaded.
        if (preg_match('/\.(?:css|js|png|jpg|jpeg|gif|ico)$/', $_SERVER['REQUEST_URI'])) {
            setMimeType($_SERVER['REQUEST_URI']);
            readfile(base_path('public' . $_SERVER['REQUEST_URI']));
            exit;
        }

        require(base_path('public/index.html'));

        // ... 404 Not Found
        break;
    case FastRoute\Dispatcher::METHOD_NOT_ALLOWED:
        $allowedMethods = $routeInfo[1];
        // ... 405 Method Not Allowed
        break;
    case FastRoute\Dispatcher::FOUND:
        $handler = $routeInfo[1];
        $vars = $routeInfo[2];
        echo $handler($vars);
        break;
}

function setMimeType($filename)
{
    $mime_types = [
        'css' => 'text/css',
        'js' => 'application/javascript',
        'png' => 'image/png',
        'jpg' => 'image/jpeg',
        'jpeg' => 'image/jpeg',
        'gif' => 'image/gif',
        'ico' => 'image/x-icon',
    ];

    $ext = pathinfo($filename, PATHINFO_EXTENSION);

    if (array_key_exists($ext, $mime_types)) {
        header('Content-Type: ' . $mime_types[$ext]);
    } else {
        header('Content-Type: application/octet-stream');
    }
}
