select 
    ue.customer_id,
	ue.user_id,
	ue.event_id,
	ue.event_type,
	ue.event_timestamp,
	c.customer_name,
	c.cnt_users,
	c.remediation_action,
	de.detector_id,
	de.confidence_level as detector_confidence_level,
	ce.case_id,
	cce.reported_case_id,
	cce.report_timestamp,
	cae.action_id,
	cae.action_type,
	cae.action_timestamp,
	cae2.customer_action_type,
	cae2.customer_action_ts,
	cae2.customer_comment 
from {{ ref('user_events') }} ue
left join {{ ref('customers') }} c on ue.customer_id = c.customer_id 
left join {{ ref('detector_events') }} de on ue.event_id = de.event_id 
left join {{ ref('case_events') }} ce on ue.event_id = ce.triggering_event_id
left join {{ ref('customer_case_events') }} cce on ue.event_id = cce.reported_event_id 
left join {{ ref('case_action_events') }} cae on ce.case_id = cae.case_id 
left join {{ ref('customer_action_events') }} cae2 on ce.case_id = cae2.case_id 
order by ue.event_id asc