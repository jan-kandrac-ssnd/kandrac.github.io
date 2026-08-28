# Ensures every page has a sensible `title` for use in the browser tab
# (<title>, via jekyll-seo-tag) and in the sidebar nav, even when
# jekyll-titles-from-headings couldn't find a heading (it only matches a
# heading that is the very first line of the file).
#
# Runs as a `pre_render` hook so it fires after ALL generators (including
# jekyll-titles-from-headings) have already had a chance to set a real title
# from the page's first heading - this only fills in the gaps.
Jekyll::Hooks.register :site, :pre_render do |site|
  site.pages.each do |page|
    next unless [".md", ".markdown"].include?(page.extname)
    next unless page.data["title"].to_s.strip.empty?
    next if page.url == "/" # keep the homepage on the site-wide title

    if page.basename.casecmp("README").zero?
      # Folder index page (e.g. Kotlin/README.md) -> use the folder name,
      # e.g. "Kotlin" or "FlutterFlow".
      dir_name = File.basename(File.dirname(page.relative_path))
      title = dir_name.tr("-", " ").strip
    else
      # Regular lesson page without a leading heading -> derive from the
      # filename, e.g. "5.1-Plna-definicia-funkcie.md" -> "5.1 Plna definicia funkcie".
      title = page.basename.tr("-", " ").strip
    end

    page.data["title"] = title unless title.empty?
  end
end
