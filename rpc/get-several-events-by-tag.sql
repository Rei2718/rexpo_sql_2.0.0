-- get_several_events_by_tag

CREATE OR REPLACE FUNCTION get_several_events_by_tag()
RETURNS JSONB
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
    RETURN COALESCE(
        (
            SELECT jsonb_agg(
                jsonb_build_object(
                    'tag_public_id', mv.tag_public_id,
                    'name',          mv.name,
                    'caption',       mv.caption,
                    'events',        (
                        SELECT COALESCE(jsonb_agg(e), '[]'::jsonb)
                        FROM (
                            SELECT e
                            FROM jsonb_array_elements(mv.events) AS e
                            LIMIT 4
                        ) AS limited_events
                    ),
                    'display_order', mv.tag_display_order
                ) ORDER BY mv.tag_display_order DESC
            )
            FROM public.mv_tag_events mv
        ),
        '[]'::jsonb
    );
END;
$$ LANGUAGE plpgsql;

REVOKE EXECUTE ON FUNCTION public.get_several_events_by_tag FROM public;
GRANT EXECUTE ON FUNCTION public.get_several_events_by_tag TO authenticated, anon;