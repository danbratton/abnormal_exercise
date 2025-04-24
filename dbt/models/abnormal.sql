WITH latest_customer_action_events AS (
SELECT
	DISTINCT ON
	(case_id)
		case_id,
		customer_action_ts AS latest_customer_action_ts,
		customer_action_type AS latest_customer_action_type,
	customer_comment AS latest_customer_comment
FROM
	{{ ref('customer_action_events') }} cae
ORDER BY
	case_id ASC,
	customer_action_ts DESC
)

SELECT
	ue.event_id,
	ue.customer_id,
	ue.user_id,
	ue.event_type,
	ue.event_timestamp,
	c.customer_name,
	c.cnt_users,
	c.remediation_action,
	de.detector_id,
	de.confidence_level AS detector_confidence_level,
	ce.case_id,
	ce.triggering_event_id,
	cce.reported_case_id,
	cce.report_timestamp,
	cae.action_id,
	cae.action_type,
	cae.action_timestamp,
	cae2.latest_customer_action_type,
	cae2.latest_customer_action_ts,
	cae2.latest_customer_comment
FROM
	{{ ref('user_events') }} ue
LEFT JOIN {{ ref('customers') }} c ON
	ue.customer_id = c.customer_id
LEFT JOIN {{ ref('detector_events') }} de ON
	ue.event_id = de.event_id
LEFT JOIN {{ ref('case_events') }} ce ON
	ue.event_id = ce.triggering_event_id
LEFT JOIN {{ ref('customer_case_events') }} cce ON
	ue.event_id = cce.reported_event_id
LEFT JOIN {{ ref('case_action_events') }} cae ON
	ce.case_id = cae.case_id
LEFT JOIN latest_customer_action_events cae2 ON
	ce.case_id = cae2.case_id
ORDER BY
	ue.event_id ASC