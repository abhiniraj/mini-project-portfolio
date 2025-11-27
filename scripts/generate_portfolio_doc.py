"""
Generate a Word (.docx) document from the Markdown summary in `docs/Portfolio_Functionality.md`.
This script uses `python-docx` (install via `pip install python-docx`).
"""
import sys
from pathlib import Path

MD = Path(__file__).resolve().parents[1] / 'docs' / 'Portfolio_Functionality.md'
OUT = Path(__file__).resolve().parents[1] / 'docs' / 'Portfolio_Functionality.docx'

if not MD.exists():
    print("Markdown source not found:", MD)
    sys.exit(1)

try:
    from docx import Document
    from docx.shared import Pt
except Exception as e:
    print("Missing dependency 'python-docx'. Install with: pip install python-docx")
    print("Error:", e)
    sys.exit(2)

text = MD.read_text(encoding='utf-8')
lines = text.splitlines()

doc = Document()
style = doc.styles['Normal']
font = style.font
font.name = 'Calibri'
font.size = Pt(11)

for line in lines:
    line = line.rstrip()
    if not line:
        doc.add_paragraph('')
        continue
    if line.startswith('# '):
        doc.add_heading(line[2:].strip(), level=1)
    elif line.startswith('## '):
        doc.add_heading(line[3:].strip(), level=2)
    elif line.startswith('- '):
        # gather bullet block
        p = doc.add_paragraph(style='List Bullet')
        p.add_run(line[2:].strip())
    elif line.startswith('1. '):
        p = doc.add_paragraph(style='List Number')
        p.add_run(line[3:].strip())
    else:
        doc.add_paragraph(line)

try:
    doc.save(OUT)
    print(f"Generated Word document: {OUT}")
except Exception as e:
    print("Failed to save docx:", e)
    sys.exit(3)
