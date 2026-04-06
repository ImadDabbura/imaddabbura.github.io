function Pandoc(doc)
  if doc.meta.status then
    local status = pandoc.utils.stringify(doc.meta.status)
    local badge = pandoc.RawBlock('html',
      '<div class="status-badge-container" style="margin-bottom: 1rem;">' ..
      '<span class="status-badge ' .. status .. '">' .. status .. '</span>' ..
      '</div>')
    table.insert(doc.blocks, 1, badge)
    return doc
  end
end
