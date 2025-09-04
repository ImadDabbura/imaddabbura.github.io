# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a personal website built with Quarto, a publishing system for scientific and technical content. The site features blog posts about machine learning, data science, programming, and technical tutorials, along with paper summaries, projects, and personal notes.

## Technology Stack

- **Quarto**: Static site generator for scientific and technical publishing
- **Python**: For notebooks, scripts, and data analysis examples
- **Jupyter Notebooks**: Interactive content for technical posts
- **HTML/CSS/JavaScript**: Generated output for web deployment
- **GitHub Pages**: Hosting platform (deploys to `docs/` directory)

## Development Commands

### Building the Site
```bash
quarto render
```
This renders all `.qmd` and `.ipynb` files to HTML in the `docs/` directory.

### Preview During Development
```bash
quarto preview
```
Starts a local development server with live reload.

### Publishing
The site auto-deploys to GitHub Pages from the `docs/` directory when changes are pushed to the main branch.

## Project Structure

### Content Organization
- **Posts** (`posts/`): Technical blog posts organized by topic (e.g., `nlp/`, `python/`, `airflow/`)
- **Papers Summaries** (`papers-summaries/`): Research paper summaries and notes
- **TIL** (`til/`): "Today I Learned" short notes organized by technology
- **Projects** (`projects/`): Portfolio project descriptions
- **Books/Misc Notes** (`books-summaries/`, `misc-notes/`): Additional content sections

### File Types
- **`.qmd`**: Quarto markdown files (main content format)
- **`.ipynb`**: Jupyter notebooks (for code-heavy technical content)
- **`.md`**: Standard markdown (some legacy content)
- **`_metadata.yml`**: Directory-specific metadata and configuration

### Key Configuration
- **`_quarto.yml`**: Main site configuration, navigation, themes, and build settings
- **`styles.css`**: Custom CSS styling
- **`_citation.qmd`**: Citation format included in all pages

## Content Creation Workflow

1. **Blog Posts**: Create in appropriate `posts/[category]/` subdirectory
2. **Notebooks**: Use for interactive, code-heavy content with visualizations
3. **Images**: Store in topic-specific `images/` subdirectories or main `images/` folder
4. **Metadata**: Include proper YAML frontmatter with title, date, categories, and features

## Development Notes

- The site uses Quarto's listing feature for automatic post organization
- Search functionality powered by Algolia
- Comments system integrated via Giscus
- Google Analytics tracking configured
- Dark/light theme support via Bootstrap themes
- Social media integration (Twitter, LinkedIn, GitHub)

## Python Dependencies

The site includes Python scripts and utilities primarily for:
- Bandit algorithm implementations and plotting (`posts/scripts/`)
- BPE tokenizer implementation (`bpe.py`)
- Data analysis examples in notebooks
- Machine learning tutorials and implementations

Most Python code is self-contained within individual post directories or serves as educational examples rather than production dependencies.