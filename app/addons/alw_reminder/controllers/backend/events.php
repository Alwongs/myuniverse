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

use Tygh\Registry; 

defined('BOOTSTRAP') or die('Access denied');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    if ($mode === 'update') {

        if (empty($_REQUEST['event_data']['event'])) {
            fn_set_notification('E', __('error'), __('need_event_name'));
            return [CONTROLLER_STATUS_REDIRECT, 'products.add'];
        }

        if ($_REQUEST['event_id'] == 0) {
            $_REQUEST['event_data']['user_id'] = $auth['user_id'];
        }

        $event_id = fn_alw_reminder_update_event($_REQUEST['event_data'], $_REQUEST['event_id'], $auth['user_id']);

        if (!empty($_REQUEST['redirect_url'])) {
            $redirect_url = $_REQUEST['redirect_url'];
        } else {
            $redirect_url = $_REQUEST['event_id'] == 0 ? 'events.manage' : 'events.update?event_id=' . $event_id;
        }
    }

    if ($mode === 'delete') {
        if (!empty($_REQUEST['event_id'])) {
            $result = fn_alw_reminder_delete_event($_REQUEST['event_id']);

            if ($result) {
                fn_set_notification('N', __('notice'), __('alw_reminder.event_has_been_deleted'));
            } else {
                return [CONTROLLER_STATUS_REDIRECT, 'events.update?event_id=' . $_REQUEST['event_id']];
            }
        }

        return [CONTROLLER_STATUS_REDIRECT, 'events.manage'];
    }

    if ($mode == 'm_delete') {

        if (!empty($_REQUEST['event_ids'])) {
            fn_alw_reminder_delete_events($_REQUEST['event_ids']);
        }   

        return [CONTROLLER_STATUS_REDIRECT, 'events.manage'];
    }


    if ($mode == 'postpone') {

        if ($_REQUEST['event_data']['type'] == 'M') {
            $new_timestamp = fn_alw_reminder_add_month($_REQUEST['event_data']['timestamp']);
        } 

        if ($_REQUEST['event_data']['type'] == 'A') {
            $new_timestamp = fn_alw_reminder_add_year($_REQUEST['event_data']['timestamp']);
        } 




        $result = fn_alw_reminder_update_timestamp_in_event($_REQUEST['event_id'], $new_timestamp);

        $redirect_url = $_REQUEST['redirect_url'];

    }

    return [CONTROLLER_STATUS_OK, $redirect_url];
}






if ($mode == 'update') {

    $event = !empty($_REQUEST['event_id']) ? fn_alw_reminder_get_event_data($_REQUEST['event_id']) : []; 

    $redirect_url = !empty($_REQUEST['page_url']) ? $_REQUEST['page_url'] : '';

    Tygh::$app['view']->assign([
        'event' => $event,
        'redirect_url' => $redirect_url
    ]);

} elseif ($mode == 'manage') {

    if (!empty($auth['user_id'])) {
        $events = fn_alw_reminder_get_events($auth['user_id']);
    }

    Tygh::$app['view']->assign('events', $events);
}

