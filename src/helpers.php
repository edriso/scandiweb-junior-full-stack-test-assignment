<?php

function dd($value)
{
    echo '<pre>';
    var_dump($value);
    echo '</pre>';

    die();
}

function base_path($path)
{
    return BASE_PATH . $path;
}

function abort($code = 404, $message = 'Resource not found')
{
    http_response_code($code);

    header('Content-Type: application/json');
    echo json_encode(['error' => $message]);

    die();
}
