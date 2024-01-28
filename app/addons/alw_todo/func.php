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

function fn_alw_todo_get_tasks($user_id) {

    $tasks = db_get_array("SELECT * FROM ?:alw_tasks WHERE user_id = ?i", $user_id);

    return $tasks;
}

function fn_alw_todo_get_task($task_id) {

    $task = db_get_row("SELECT * FROM ?:alw_tasks WHERE task_id = ?i", $task_id);

    return $task ?? [];
}

function fn_alw_todo_update_task($task, $task_id = 0)
{
    if (empty($task_id)) {

        if (empty($task['task']) || !empty($task['task_id'])) {
            fn_set_notification('E', __('error'), __('need_task_name'));
            return false;
        }
        $task_id = db_query("INSERT INTO ?:alw_tasks ?e", $task);
    } else {
        db_query("UPDATE ?:alw_tasks SET ?u WHERE task_id = ?i", $task, $task_id);
    }

    return (int) $task_id;
}

function fn_alw_todo_delete_task($task_id)
{

    if (!empty($task_id)) {

        $result = db_query('DELETE FROM ?:alw_tasks WHERE task_id = ?i', $task_id);
    }

    return $result;
}

function fn_alw_todo_delete_tasks($task_ids) 
{
    db_query('DELETE FROM ?:alw_tasks WHERE task_id IN (?n)', $task_ids); 
}
