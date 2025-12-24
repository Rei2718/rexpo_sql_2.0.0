-- get_display_venue

CREATE OR REPLACE FUNCTION get_display_venue()
RETURNS JSONB
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
    RETURN COALESCE(
        (SELECT data FROM public.mv_display_venues WHERE id = 1),
        '[]'::jsonb
    );
END;
$$ LANGUAGE plpgsql;

REVOKE EXECUTE ON FUNCTION public.get_display_venue FROM public;
GRANT EXECUTE ON FUNCTION public.get_display_venue TO authenticated, anon;