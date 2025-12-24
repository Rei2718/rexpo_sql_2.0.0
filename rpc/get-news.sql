-- get_news

CREATE OR REPLACE FUNCTION get_news()
RETURNS JSONB
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
    RETURN COALESCE(
        (SELECT data FROM public.mv_news WHERE id = 1),
        '[]'::jsonb
    );
END;
$$ LANGUAGE plpgsql;

REVOKE EXECUTE ON FUNCTION public.get_news FROM public;
GRANT EXECUTE ON FUNCTION public.get_news TO authenticated, anon;