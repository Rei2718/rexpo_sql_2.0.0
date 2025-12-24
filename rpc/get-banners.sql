-- get_banners

CREATE OR REPLACE FUNCTION get_banners()
RETURNS JSONB
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
    RETURN COALESCE(
        (SELECT data FROM public.mv_banners WHERE id = 1),
        '[]'::jsonb
    );
END;
$$ LANGUAGE plpgsql;

REVOKE EXECUTE ON FUNCTION public.get_banners FROM public;
GRANT EXECUTE ON FUNCTION public.get_banners TO authenticated, anon;