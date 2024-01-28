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

        if (empty($_REQUEST['task_data']['task'])) {
            fn_set_notification('E', __('error'), __('need_product_name'));
            return [CONTROLLER_STATUS_REDIRECT, 'tasks.add'];
        }

        if ($_REQUEST['task_id'] == 0) {
            $_REQUEST['task_data']['user_id'] = $auth['user_id'];
        }

        $task_id = fn_alw_todo_update_task($_REQUEST['task_data'], $_REQUEST['task_id'], $auth['user_id']);

        if (!empty($_REQUEST['redirect_url'])) {
            $redirect_url = $_REQUEST['redirect_url'];
        } else {
            $redirect_url = $_REQUEST['task_id'] == 0 ? 'tasks.manage' : 'tasks.update?task_id=' . $task_id;
        }
    }

    if ($mode === 'delete') {
        if (!empty($_REQUEST['task_id'])) {
            $result = fn_alw_todo_delete_task($_REQUEST['task_id']);

            if ($result) {
                fn_set_notification('N', __('notice'), __('alw_todo.task_has_been_deleted'));
            } else {
                return [CONTROLLER_STATUS_REDIRECT, 'tasks.update?task_id=' . $_REQUEST['task_id']];
            }
        }

        return [CONTROLLER_STATUS_REDIRECT, 'tasks.manage'];
    }

    if ($mode == 'm_delete') {

        if (!empty($_REQUEST['task_ids'])) {
            fn_alw_todo_delete_tasks($_REQUEST['task_ids']);
        }   

        return [CONTROLLER_STATUS_REDIRECT, 'tasks.manage'];
    }

    return [CONTROLLER_STATUS_OK, $redirect_url];
}






if ($mode == 'update') {

    $task = !empty($_REQUEST['task_id']) ? fn_alw_todo_get_task($_REQUEST['task_id']) : []; 

    $redirect_url = !empty($_REQUEST['page_url']) ? $_REQUEST['page_url'] : '';

    Tygh::$app['view']->assign([
        'task' => $task,
        'redirect_url' => $redirect_url
    ]);

} elseif ($mode == 'manage') {

    if (!empty($auth['user_id'])) {
        $tasks = fn_alw_todo_get_tasks($auth['user_id']);
    }

    Tygh::$app['view']->assign('tasks', $tasks);
}

