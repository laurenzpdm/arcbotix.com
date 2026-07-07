// Arcbotix privacy-gated analytics loader.
// PostHog (EU Cloud) is never loaded and no analytics cookie/localStorage
// tracking key is ever set until the visitor explicitly clicks "Accept".
// "Decline" or leaving the banner untouched means zero PostHog script load.
(function () {
  var CONSENT_KEY = "arcbotix_consent";
  var POSTHOG_TOKEN = "phc_rS2jbgsemYNjdyj86b6rDCdmvo3rYmfgr5rKrAXUoSdF";
  var POSTHOG_HOST = "https://eu.i.posthog.com";

  function loadPostHog() {
    if (window.posthog && window.posthog.__loaded) return;
    !function (t, e) { var o, n, p, r; e.__SV || (window.posthog && window.posthog.__loaded) || (window.posthog = e, e._i = [], e.init = function (i, s, a) { function g(t, e) { var o = e.split("."); 2 == o.length && (t = t[o[0]], e = o[1]), t[e] = function () { t.push([e].concat(Array.prototype.slice.call(arguments, 0))) } }(p = t.createElement("script")).type = "text/javascript", p.crossOrigin = "anonymous", p.async = !0, p.src = s.api_host.replace(".i.posthog.com", "-assets.i.posthog.com") + "/static/array.js", (r = t.getElementsByTagName("script")[0]).parentNode.insertBefore(p, r); var u = e; for (void 0 !== a ? u = e[a] = [] : a = "posthog", u.people = u.people || [], u.toString = function (t) { var e = "posthog"; return "posthog" !== a && (e += "." + a), t || (e += " (stub)"), e }, u.people.toString = function () { return u.toString(1) + ".people (stub)" }, o = "init Ei Pi ws ks Ss Rs capture Ge calculateEventProperties Os register register_once register_for_session unregister unregister_for_session As js getFeatureFlag getFeatureFlagPayload getFeatureFlagResult getAllFeatureFlags isFeatureEnabled reloadFeatureFlags updateFlags updateEarlyAccessFeatureEnrollment getEarlyAccessFeatures on onFeatureFlags onSurveysLoaded onSessionId getSurveys getActiveMatchingSurveys renderSurvey displaySurvey cancelPendingSurvey canRenderSurvey canRenderSurveyAsync xs identify setPersonProperties unsetPersonProperties group resetGroups setPersonPropertiesForFlags resetPersonPropertiesForFlags setGroupPropertiesForFlags resetGroupPropertiesForFlags reset shutdown setIdentity clearIdentity get_distinct_id getGroups get_session_id get_session_replay_url alias set_config startSessionRecording stopSessionRecording sessionRecordingStarted captureException addExceptionStep captureLog startExceptionAutocapture stopExceptionAutocapture loadToolbar get_property getSessionProperty ms Cs bs opt_in_capturing opt_out_capturing has_opted_in_capturing has_opted_out_capturing get_explicit_consent_status is_capturing clear_opt_in_out_capturing Ts debug _s getPageViewId captureTraceFeedback captureTraceMetric Ns".split(" "), n = 0; n < o.length; n++)g(u, o[n]); e._i.push([i, s, a]) }, e.__SV = 1) }(document, window.posthog || []);

    window.posthog.init(POSTHOG_TOKEN, {
      api_host: POSTHOG_HOST,
      person_profiles: "identified_only",
      session_recording: { maskAllInputs: true, maskTextSelector: "*" }
    });
  }

  function getConsent() {
    try { return localStorage.getItem(CONSENT_KEY); } catch (e) { return null; }
  }
  function setConsent(value) {
    try { localStorage.setItem(CONSENT_KEY, value); } catch (e) { /* no-op if storage blocked */ }
  }

  function initBanner() {
    var banner = document.getElementById("consent-banner");
    if (!banner) return;
    var acceptBtn = document.getElementById("consent-accept");
    var declineBtn = document.getElementById("consent-decline");

    acceptBtn.addEventListener("click", function () {
      setConsent("granted");
      banner.hidden = true;
      loadPostHog();
    });
    declineBtn.addEventListener("click", function () {
      setConsent("denied");
      banner.hidden = true;
    });

    banner.hidden = false;
  }

  var consent = getConsent();
  if (consent === "granted") {
    loadPostHog();
  } else if (consent !== "denied") {
    document.addEventListener("DOMContentLoaded", initBanner);
  }
})();
