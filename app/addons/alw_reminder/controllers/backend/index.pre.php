<?php
/***************************************************************************
*                                                                          *
*   (c) 2004 Vladimir V. Kalynyak, Alexey V. Vinokurov, Ilya M. Shalnev    *
*                                                                          *
* This  is  commercial  software,  only  users  who have purchased a valid *
* license  and  accept  to the terms of the  License Agreement can install *
* and use this program.                                                    *
*                                                                          *
****************************************************************************
* PLEASE READ THE FULL TEXT  OF THE SOFTWARE  LICENSE   AGREEMENT  IN  THE *
* "copyright.txt" FILE PROVIDED WITH THIS DISTRIBUTION PACKAGE.            *
****************************************************************************/

if (!defined('BOOTSTRAP')) { die('Access denied'); }

$auth = Tygh::$app['session']['auth'];

if ($mode == 'index') {

    if (!empty($auth['user_id'])) {
        $events = fn_alw_reminder_get_events($auth['user_id']);

        list($overdue, $today, $tomorrow, $in_week) = fn_alw_reminder_chunck_events_by_periods($events);
    
        Tygh::$app['view']->assign([
            'description' => 'from controller',
            'overdue' => $overdue,
            'today' => $today,
            'tomorrow' => $tomorrow,
            'in_week' => $in_week,
        ]);
    }

    return;
}
