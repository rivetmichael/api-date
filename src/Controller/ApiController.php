<?php

namespace App\Controller;

use Carbon\Carbon;
use Symfony\Component\HttpFoundation\Response;

class ApiController {

    private $defaultTimezone;

    public function __construct(string $defaultTimezone)
    {
        $this->defaultTimezone = $defaultTimezone;
    }

    public function getDateAction()
    {
        return new Response(
            Carbon::now($this->defaultTimezone)->toDateTimeString()
        );
    }

}
