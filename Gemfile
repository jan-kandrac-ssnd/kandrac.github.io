source "https://rubygems.org"

gem "jekyll", "~> 4.3"

# Official GitHub Pages theme (https://github.com/pages-themes/midnight),
# usable standalone since we deploy via a GitHub Actions workflow instead
# of the classic/legacy GitHub Pages build.
gem "jekyll-theme-midnight"

# Plugins that let a repo full of plain Markdown notes (no front matter)
# work as a themed, browsable site.
group :jekyll_plugins do
  # Rewrites links between local .md files to point at the rendered page
  # instead of the raw Markdown file.
  # NOTE: needs >= 0.7, since that's when URL-decoding support (for any
  # future %XX-encoded paths) was added - this is exactly why we can't use
  # the `github-pages` gem, which still pins an old 0.6.1 without it.
  gem "jekyll-relative-links", "~> 0.8"
  gem "jekyll-optional-front-matter" # treat .md files as pages even without front matter
  gem "jekyll-readme-index"          # serve each folder's README.md as that folder's index page
  gem "jekyll-titles-from-headings"  # use the first heading as the page title
  gem "jekyll-seo-tag"
  gem "jekyll-sitemap"
end

# Ruby 3+ no longer ships webrick by default, but `jekyll serve` needs it for local dev
gem "webrick", "~> 1.8"
