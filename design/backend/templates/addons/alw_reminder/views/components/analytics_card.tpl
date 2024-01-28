
<div class="{if $title}analytics-card{/if} alw-event-card">
    <h3 class="alw-event-card__title">{$title}</h3>
    <ul class="alw-event-card__event-list">
        {foreach $data as $event}
            {$type = $event.type}
        <li class="alw-event-card__event-item alw-event-item">
            <div class="alw-event-item__name">
                <a class="event-list__item-link" 
                    href="{"events.update?event_id=`$event.event_id`&page_url=index.index"|fn_url}"
                    title="{$event.description}"
                >{$event.event}</a>
            </div>
            <div class="alw-event-item__actions">
                <form action="{"events.{if $type == 'U'}delete{else}postpone{/if}?event_id=`$event.event_id`&redirect_url=index.index"|fn_url}" method="post">  
                    <input type="hidden" name="event_data[timestamp]" value="{$event.timestamp}" />
                    <input type="hidden" name="event_data[type]" value="{$event.type}" />

                    <input type="submit" class="cm-confirm cell-btn {if $type == 'U'} btn-icon-delete {else} btn-icon-postpone{/if}" value="" />
                </form>
            </div>
        </li>
        {/foreach}
    </ul>
</div>
