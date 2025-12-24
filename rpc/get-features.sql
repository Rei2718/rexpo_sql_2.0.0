-- get_features

CREATE OR REPLACE FUNCTION get_features()
RETURNS JSONB
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
    RETURN COALESCE(
        (SELECT data FROM public.mv_features WHERE id = 1),
        '[]'::jsonb
    );
END;
$$ LANGUAGE plpgsql;

REVOKE EXECUTE ON FUNCTION public.get_features FROM public;
GRANT EXECUTE ON FUNCTION public.get_features TO authenticated, anon;