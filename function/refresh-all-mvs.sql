-- refresh_all_mvs

CREATE OR REPLACE FUNCTION refresh_all_mvs()
RETURNS TRIGGER
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
    -- 依存関係順にリフレッシュ（CONCURRENTLYをつけるとロックされない）
    -- 基礎MV
    REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_event_details;
    REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_venue_details;

    -- 派生MV
    REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_tag_events;
    REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_venue_timeline;
    REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_category_tree;

    -- 静的リストMV
    REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_banners;
    REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_news;
    REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_features;
    REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_display_venues;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

REVOKE EXECUTE ON FUNCTION public.refresh_all_mvs FROM public;