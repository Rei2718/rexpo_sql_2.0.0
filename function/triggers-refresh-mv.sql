-- triggers_refresh_mv

-- events
DROP TRIGGER IF EXISTS trigger_refresh_mvs_events ON public.events;
CREATE TRIGGER trigger_refresh_mvs_events
    AFTER INSERT OR UPDATE OR DELETE ON public.events
    FOR EACH STATEMENT
    EXECUTE FUNCTION refresh_all_mvs();

-- tags
DROP TRIGGER IF EXISTS trigger_refresh_mvs_tags ON public.tags;
CREATE TRIGGER trigger_refresh_mvs_tags
    AFTER INSERT OR UPDATE OR DELETE ON public.tags
    FOR EACH STATEMENT
    EXECUTE FUNCTION refresh_all_mvs();

-- categories
DROP TRIGGER IF EXISTS trigger_refresh_mvs_categories ON public.categories;
CREATE TRIGGER trigger_refresh_mvs_categories
    AFTER INSERT OR UPDATE OR DELETE ON public.categories
    FOR EACH STATEMENT
    EXECUTE FUNCTION refresh_all_mvs();

-- venues
DROP TRIGGER IF EXISTS trigger_refresh_mvs_venues ON public.venues;
CREATE TRIGGER trigger_refresh_mvs_venues
    AFTER INSERT OR UPDATE OR DELETE ON public.venues
    FOR EACH STATEMENT
    EXECUTE FUNCTION refresh_all_mvs();

-- organizations
DROP TRIGGER IF EXISTS trigger_refresh_mvs_organizations ON public.organizations;
CREATE TRIGGER trigger_refresh_mvs_organizations
    AFTER INSERT OR UPDATE OR DELETE ON public.organizations
    FOR EACH STATEMENT
    EXECUTE FUNCTION refresh_all_mvs();

-- performers
DROP TRIGGER IF EXISTS trigger_refresh_mvs_performers ON public.performers;
CREATE TRIGGER trigger_refresh_mvs_performers
    AFTER INSERT OR UPDATE OR DELETE ON public.performers
    FOR EACH STATEMENT
    EXECUTE FUNCTION refresh_all_mvs();

-- slots
DROP TRIGGER IF EXISTS trigger_refresh_mvs_slots ON public.slots;
CREATE TRIGGER trigger_refresh_mvs_slots
    AFTER INSERT OR UPDATE OR DELETE ON public.slots
    FOR EACH STATEMENT
    EXECUTE FUNCTION refresh_all_mvs();

-- banners
DROP TRIGGER IF EXISTS trigger_refresh_mvs_banners ON public.banners;
CREATE TRIGGER trigger_refresh_mvs_banners
    AFTER INSERT OR UPDATE OR DELETE ON public.banners
    FOR EACH STATEMENT
    EXECUTE FUNCTION refresh_all_mvs();

-- news
DROP TRIGGER IF EXISTS trigger_refresh_mvs_news ON public.news;
CREATE TRIGGER trigger_refresh_mvs_news
    AFTER INSERT OR UPDATE OR DELETE ON public.news
    FOR EACH STATEMENT
    EXECUTE FUNCTION refresh_all_mvs();

-- features
DROP TRIGGER IF EXISTS trigger_refresh_mvs_features ON public.features;
CREATE TRIGGER trigger_refresh_mvs_features
    AFTER INSERT OR UPDATE OR DELETE ON public.features
    FOR EACH STATEMENT
    EXECUTE FUNCTION refresh_all_mvs();

-- events_tags
DROP TRIGGER IF EXISTS trigger_refresh_mvs_events_tags ON public.events_tags;
CREATE TRIGGER trigger_refresh_mvs_events_tags
    AFTER INSERT OR UPDATE OR DELETE ON public.events_tags
    FOR EACH STATEMENT
    EXECUTE FUNCTION refresh_all_mvs();

-- events_venues
DROP TRIGGER IF EXISTS trigger_refresh_mvs_events_venues ON public.events_venues;
CREATE TRIGGER trigger_refresh_mvs_events_venues
    AFTER INSERT OR UPDATE OR DELETE ON public.events_venues
    FOR EACH STATEMENT
    EXECUTE FUNCTION refresh_all_mvs();

-- events_slots
DROP TRIGGER IF EXISTS trigger_refresh_mvs_events_slots ON public.events_slots;
CREATE TRIGGER trigger_refresh_mvs_events_slots
    AFTER INSERT OR UPDATE OR DELETE ON public.events_slots
    FOR EACH STATEMENT
    EXECUTE FUNCTION refresh_all_mvs();

-- events_performers
DROP TRIGGER IF EXISTS trigger_refresh_mvs_events_performers ON public.events_performers;
CREATE TRIGGER trigger_refresh_mvs_events_performers
    AFTER INSERT OR UPDATE OR DELETE ON public.events_performers
    FOR EACH STATEMENT
    EXECUTE FUNCTION refresh_all_mvs();

-- tags_categories
DROP TRIGGER IF EXISTS trigger_refresh_mvs_tags_categories ON public.tags_categories;
CREATE TRIGGER trigger_refresh_mvs_tags_categories
    AFTER INSERT OR UPDATE OR DELETE ON public.tags_categories
    FOR EACH STATEMENT
    EXECUTE FUNCTION refresh_all_mvs();

-- venues_organizations
DROP TRIGGER IF EXISTS trigger_refresh_mvs_venues_organizations ON public.venues_organizations;
CREATE TRIGGER trigger_refresh_mvs_venues_organizations
    AFTER INSERT OR UPDATE OR DELETE ON public.venues_organizations
    FOR EACH STATEMENT
    EXECUTE FUNCTION refresh_all_mvs();