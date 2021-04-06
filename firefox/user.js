// PREF: Don't trim HTTP off of URLs in the address bar.
user_pref("browser.urlbar.trimURLs",				false);

// PREF: Don't try to guess domain names when entering an invalid domain name in URL bar
user_pref("browser.fixup.alternate.enabled",			false);

// PREF: Don't monitor OS online/offline connection state
user_pref("network.manage-offline-status",			false);

// PREF: Disable sending Flash Player crash reports
user_pref("dom.ipc.plugins.flash.subprocess.crashreporter.enabled",	false);

// PREF: When Flash crash reports are enabled, don't send the visited URL in the crash report
user_pref("dom.ipc.plugins.reportCrashURL",			false);

// PREF: Disable Mozilla telemetry/experiments
user_pref("toolkit.telemetry.enabled",				false);
user_pref("toolkit.telemetry.unified",				false);

// PREF: Disable sending Firefox crash reports to Mozilla servers
user_pref("breakpad.reportURL",					"");

// PREF: Disable sending reports of tab crashes to Mozilla (about:tabcrashed), don't nag user about unsent crash reports
user_pref("browser.tabs.crashReporting.sendReport",		false);

// PREF: Disable the UITour backend
user_pref("browser.uitour.enabled",				false);

// PREF: Enable Firefox Tracking Protection
user_pref("privacy.trackingprotection.enabled",			true);

// PREF: Disable the built-in PDF viewer
user_pref("pdfjs.disabled",					true);

// PREF: Disable collection/sending of the health report (healthreport.sqlite*)
user_pref("datareporting.healthreport.uploadEnabled",		false);
user_pref("datareporting.policy.dataSubmissionEnabled",		false);

// PREF: Disable querying Google Application Reputation database for downloaded binary files
user_pref("browser.safebrowsing.downloads.remote.enabled",	false);

// PREF: Disable Pocket
user_pref("extensions.pocket.enabled",				false);

// PREF: Disable "Recommended by Pocket" in Firefox Quantum
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories",	false);

// PREF: DNT HTTP header (disabled)
// NOTICE: Do No Track must be enabled manually
user_pref("privacy.donottrackheader.enabled",		true);

// PREF: Accept Only 1st Party Cookies
user_pref("network.cookie.cookieBehavior",			1);

// PREF: Make sure that third-party cookies (if enabled) never persist beyond the session.
user_pref("network.cookie.thirdparty.sessionOnly",		true);

// PREF: Disable password manager
user_pref("signon.rememberSignons",				false);

// PREF: Disable Downloading on Desktop
user_pref("browser.download.folderList",			2);

// PREF: Disable Activity Stream
user_pref("browser.newtabpage.activity-stream.enabled",		false);

// PREF: Do not check if Firefox is the default browser
user_pref("browser.shell.checkDefaultBrowser",			false);

user_pref("browser.aboutConfig.showWarning" false);
user_pref("browser.bookmarks.restore_default_bookmarks" false);
user_pref("browser.bookmarks.showMobileBookmarks" false);
user_pref("browser.contentblocking.category" "strict");
user_pref("browser.ctrlTab.recentlyUsedOrder" false);
user_pref("browser.discovery.enabled" false);
user_pref("browser.download.panel.show" true);
user_pref("browser.eme.ui.firstContentShown" true);
user_pref("browser.fixup.domainwhitelist.hodor.hodor" true);
user_pref("browser.fixup.domainwhitelist.pi.tau.hodor" true);
user_pref("browser.in-content.dark-mode" true);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" false);
user_pref("browser.newtabpage.activity-stream.feeds.section.highlights" false);
user_pref("browser.newtabpage.activity-stream.feeds.snippets" false);
user_pref("browser.newtabpage.activity-stream.feeds.topsites" false);
user_pref("browser.newtabpage.activity-stream.impressionId" false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includeBookmarks" false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includeDownloads" false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includeVisited" false);
user_pref("browser.newtabpage.activity-stream.showSearch" false);
user_pref("browser.tabs.warnOnClose" false);
user_pref("browser.uidensity" 1);
user_pref("browser.urlbar.suggest.openpage" false);
user_pref("font.name-list.emoji" "emoji");
user_pref("full-screen-api.warning.timeout" 0);
user_pref("gfx.font_rendering.fontconfig.max_generic_substitutions" 127);
user_pref("gfx.webrender.all" true);
user_pref("layers.acceleration.force-enabled" true);
user_pref("layout.frame_rate" 144);
user_pref("media.ffmpeg.vaapi.enabled" true);
user_pref("media.hardware-video-decoding.force-enabled" true);
user_pref("network.security.esni.enabled" true);
user_pref("ui.systemUsesDarkTheme" 1);
user_pref("webgl.force-enabled" true);
user_pref("webgl.msaa-force" true);

user_pref("geo.provider.network.url", "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%");

user_pref("media.peerconnection.ice.default_address_only" true);

user_pref("network.http.sendRefererHeader" 0);

user_pref("network.captive-portal-service.enabled" false);

user_pref("network.trr.mode" 5);

user_pref("privacy.resistFingerprinting.randomDataOnCanvasExtract", true);
