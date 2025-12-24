-- get_events_by_tag

CREATE OR REPLACE FUNCTION get_events_by_tag(
    tag_public_id UUID DEFAULT NULL
)
RETURNS JSONB
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
    IF tag_public_id IS NULL THEN
        RETURN '[]'::jsonb;
    END IF;

    RETURN COALESCE(
        (
            SELECT mv.events
            FROM public.mv_tag_events mv
            WHERE mv.tag_public_id = get_events_by_tag.tag_public_id
        ),
        '[]'::jsonb
    );
END;
$$ LANGUAGE plpgsql;

REVOKE EXECUTE ON FUNCTION public.get_events_by_tag FROM public;
GRANT EXECUTE ON FUNCTION public.get_events_by_tag TO authenticated, anon;