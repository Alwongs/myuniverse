<?php
/****************************************************************************
 *                                                                          *
 *   (c) 2023 Alexander Martynov                                            *
 *                                                                          *
 ****************************************************************************
 * PLEASE READ THE FULL TEXT  OF THE SOFTWARE  LICENSE   AGREEMENT  IN  THE *
 * "copyright.txt" FILE PROVIDED WITH THIS DISTRIBUTION PACKAGE.            *
 ****************************************************************************/

defined('BOOTSTRAP') or die('Access denied');

function fn_alw_reminder_get_events($user_id) {

    $events = db_get_array("SELECT * FROM ?:alw_events WHERE user_id = ?i ORDER BY timestamp ASC", $user_id);

    return $events;
}

function fn_alw_reminder_get_event_data($event_id) {

    $event_data = db_get_row("SELECT * FROM ?:alw_events WHERE event_id = ?i", $event_id);

    return $event_data ?? [];
}

function fn_alw_reminder_update_event($event_data, $event_id = 0)
{

    $event_data['timestamp'] = fn_parse_date($event_data['date']);
    unset($event_data['date']);
    if (empty($event_id)) {

        if (empty($event_data['event']) || !empty($event_data['event_id'])) {
            fn_set_notification('E', __('error'), __('need_event_name'));
            return false;
        }

        $event_id = db_query("INSERT INTO ?:alw_events ?e", $event_data);
    } else {
        db_query("UPDATE ?:alw_events SET ?u WHERE event_id = ?i", $event_data, $event_id);
    }

    return (int) $event_id;
}


function fn_alw_reminder_update_timestamp_in_event($event_id, $timestamp) 
{
    db_query("UPDATE ?:alw_events SET timestamp = ?i WHERE event_id = ?i", $timestamp, $event_id);
}


function fn_alw_reminder_delete_event($event_id)
{
    if (!empty($event_id)) {

        $result = db_query('DELETE FROM ?:alw_events WHERE event_id = ?i', $event_id);
    }

    return $result;
}

function fn_alw_reminder_convert_timestamp_to_date($timestamp) 
{
    $date = new DateTime();
    $date->setTimestamp($timestamp);
    return $date;
}

function fn_alw_reminder_delete_events($event_ids) 
{
    db_query('DELETE FROM ?:alw_events WHERE event_id IN (?n)', $event_ids); 
}

function fn_alw_reminder_chunck_events_by_periods($events)
{
    $now = new DateTime();
    $now->settime(0,0);
    $timezone = new DateTimeZone('Europe/Ulyanovsk');
    $now->setTimezone($timezone);

    $overdue = [];
    $today = [];
    $tomorrow = [];
    $in_week = [];

    foreach ($events as $event) {
        $eventDate = fn_alw_reminder_convert_timestamp_to_date($event['timestamp']);
        $diff = $now->diff($eventDate)->format('%R%a');

        if ($diff < 0) {
            $overdue[] = $event;
        } elseif ($diff == 0) {
            $today[] = $event;
        } elseif ($diff > 0 && $diff < 2) {
            $tomorrow[] = $event;
        } elseif ($diff >= 2 && $diff < 8) {
            $in_week[] = $event;
        }
    }   
    
    return [$overdue, $today, $tomorrow, $in_week];
}

function fn_alw_reminder_add_month($timestamp) 
{
    $time = strtotime('+1 month', $timestamp);

    return $time;
}

function fn_alw_reminder_add_year($timestamp) 
{
    $time = strtotime('+1 year', $timestamp);

    return $time;
}