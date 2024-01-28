{capture name="mainbox"}

    {$c_url=$config.current_url|fn_query_remove:"sort_by":"sort_order"}
    
    {include_ext file="common/icon.tpl" class="icon-`$search.sort_order_rev`" assign=c_icon}
    {include_ext file="common/icon.tpl" class="icon-dummy" assign=c_dummy}
    
    <form class="form-horizontal form-edit" action="{""|fn_url}" method="post" name="events_form">
        
        {include file="common/pagination.tpl" save_current_page=true save_current_url=true}
        
        {if $events}
        
            {capture name="events_table"}
                <div class="table-responsive-wrapper longtap-selection">
                    <table width="100%" class="table table-sort table-middle table--relative table-responsive">
                    <thead 
                        data-ca-bulkedit-default-object="true" 
                        data-ca-bulkedit-component="defaultObject"
                    >
                    <tr>
                        <th class="left mobile-hide" width="6%">
                            {include file="common/check_items.tpl"}
        
                            <input type="checkbox"
                                class="bulkedit-toggler hide"
                                data-ca-bulkedit-disable="[data-ca-bulkedit-default-object=true]" 
                                data-ca-bulkedit-enable="[data-ca-bulkedit-expanded-object=true]"
                            />
                        </th>
                        <th width="64%">
                            {__("name")}
                        </th>
                        <th width="10%">
                            {include file="common/table_col_head.tpl"
                                type="date"
                                text="{__("date")}"
                            }
                        </th>
                        <th width="15%">
                            {include file="common/table_col_head.tpl"
                                type="type"
                                text="{__("type")}"
                            }
                        </th>
                        <th width="5%">
                            {include file="common/table_col_head.tpl"
                                type="actions"
                                text="{__("actions")}"
                            }
                        </th>
                    </tr>
                    </thead>
                    {foreach from=$events item="event"}
                    <tbody>
                        <tr class="cm-row-status-{$tag.status|lower} cm-longtap-target"
                            data-ca-longtap-action="setCheckBox"
                            data-ca-longtap-target="input.cm-item"
                            data-ca-id="{$event.event_id}"
                        >
                            <td width="6%" class="left mobile-hide">
                                <input type="checkbox" class="cm-item cm-item-status-{$tag.status|lower} hide" value="{$event.event_id}" name="event_ids[]"/>
                            </td>
                            <td width="64%" data-th="{__("name")}">
                                <input type="text" name="events_data[{$event.event_id}][event]" value="{$event.event}" class="input-hidden alw-input-name">
                            </td>

                            <td width="10%" class="events-list__list-price" data-th="{__("date")}">
                                {$event.timestamp|date_format: "%d.%m.%Y"}
                            </td>

                            <td width="15%" data-th="{__("type")}">
                                {if $event.type == "U"}
                                    {__("alw_reminder.unique")}
                                {elseif $event.type == "M"}
                                    {__("alw_reminder.monthly")}
                                {elseif $event.type == "A"}
                                    {__("alw_reminder.annual")}
                                {/if}
                            </td>                            

                            <td width="5%" data-th="{__("tools")}">
                                <div class="">
                                    {capture name="tools_list"}
                                        <li>{btn type="list" text=__("edit") href="events.update?event_id=`$event.event_id`&page_url=events.manage"}</li>
                                        <li>{btn type="list" class="cm-confirm" text=__("delete") href="events.delete?event_id=`$event.event_id`" method="POST"}</li>
                                    {/capture}
                                    {dropdown content=$smarty.capture.tools_list}
                                </div>
                            </td>
                        </tr>
                    {/foreach}
                    </tbody>
                    </table>
                </div>
            {/capture}
        
            {include file="common/context_menu_wrapper.tpl"
                form="events_form"
                object="events"
                items=$smarty.capture.events_table
                is_check_all_shown=true
            }
        
        {else}
            <p class="no-items">{__("no_data")}</p>
        {/if}
        
        {include file="common/pagination.tpl"}
    
    </form>

{/capture}

{capture name="adv_buttons"}
    {include file="common/tools.tpl" tool_href="events.update" prefix="top" hide_tools="true" title=__("alw_reminder.add_event") icon="icon-plus"}
{/capture}

{capture name="buttons"}
    {dropdown content=$smarty.capture.tools_list}
    {if $tags}
        {include file="buttons/save.tpl" but_name="dispatch[events.m_update]" but_role="submit-link" but_target_form="events_form"}
    {/if}
{/capture}

{capture name="sidebar"}
    {include file="common/saved_search.tpl" dispatch="events.manage" view_type="events"}
    {include file="addons/tags/views/tags/components/tags_search_form.tpl" dispatch="events.manage"}
{/capture}

{include file="common/mainbox.tpl" 
    title=__("alw_reminder.events") 
    content=$smarty.capture.mainbox 
    adv_buttons=$smarty.capture.adv_buttons 
    buttons=$smarty.capture.buttons 
    sidebar=$smarty.capture.sidebar
}

