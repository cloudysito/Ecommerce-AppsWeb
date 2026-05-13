(function() {
    const STORAGE_KEY = 'site-theme';
    const toggleId = 'theme-toggle';

    function applyTheme(theme) {
        if (theme === 'light') {
            document.documentElement.classList.add('light-theme');
            const btn = document.getElementById(toggleId);
            if (btn) btn.textContent = '☀️';
        } else {
            document.documentElement.classList.remove('light-theme');
            const btn = document.getElementById(toggleId);
            if (btn) btn.textContent = '🌙';
        }
    }

    function init() {
        const stored = localStorage.getItem(STORAGE_KEY);
        if (stored === 'light') applyTheme('light');
        else applyTheme('dark');

        document.addEventListener('click', function (e) {
            if (!e.target) return;
            const btn = e.target.closest('#' + toggleId);
            if (!btn) return;
            const isLight = document.documentElement.classList.contains('light-theme');
            const newTheme = isLight ? 'dark' : 'light';
            applyTheme(newTheme);
            localStorage.setItem(STORAGE_KEY, newTheme);
        });
    }

    if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', init);
    else init();
})();

