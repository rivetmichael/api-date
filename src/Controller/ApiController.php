<?php

namespace App\Controller;

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

class ApiController {

    public function getDateAction(Request $request)
    {
        return new Response('coucou');
    }

}
