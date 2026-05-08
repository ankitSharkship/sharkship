const pptxgen = require("pptxgenjs");

const pres = new pptxgen();
pres.layout = "LAYOUT_16x9";
pres.title = "Thesis Defence - Myristica Fragrans Chitosan Hydrogel";

// === COLOR PALETTE (Deep Teal / Forest Green / Cream) ===
const C = {
  dark:    "0D3B38",  // deep teal-green
  mid:     "1A6B5A",  // forest teal
  accent:  "2EB89A",  // mint accent
  light:   "E8F5F2",  // very light mint
  white:   "FFFFFF",
  text:    "1C2B2A",
  muted:   "5C7B76",
  gold:    "E8B84B",  // warm accent for highlights
  warm:    "F5FAF9",  // near-white warm bg
};

const makeShadow = () => ({ type: "outer", blur: 8, offset: 3, angle: 135, color: "000000", opacity: 0.12 });

// ─────────────────────────────────────────────
// SLIDE 1 — TITLE
// ─────────────────────────────────────────────
{
  const sl = pres.addSlide();
  sl.background = { color: C.dark };

  // Top accent bar
  sl.addShape(pres.shapes.RECTANGLE, { x: 0, y: 0, w: 10, h: 0.08, fill: { color: C.accent } });

  // Left decorative strip
  sl.addShape(pres.shapes.RECTANGLE, { x: 0, y: 0.08, w: 0.07, h: 5.545, fill: { color: C.mid } });

  // Right large decorative circle (background)
  sl.addShape(pres.shapes.OVAL, { x: 6.8, y: -0.5, w: 4.0, h: 4.0, fill: { color: C.mid, transparency: 75 } });
  sl.addShape(pres.shapes.OVAL, { x: 7.5, y: 2.5, w: 2.5, h: 2.5, fill: { color: C.accent, transparency: 85 } });

  // Title
  sl.addText("Formulation and Characterization of", {
    x: 0.5, y: 0.7, w: 8.5, h: 0.5,
    fontSize: 16, color: C.accent, fontFace: "Calibri", italic: true, margin: 0
  });
  sl.addText("Myristica Fragrans", {
    x: 0.5, y: 1.15, w: 8.5, h: 0.85,
    fontSize: 40, color: C.white, fontFace: "Georgia", bold: true, italic: true, margin: 0
  });
  sl.addText("Based Chitosan Hydrogel", {
    x: 0.5, y: 1.95, w: 8.5, h: 0.65,
    fontSize: 28, color: C.gold, fontFace: "Georgia", bold: false, margin: 0
  });

  // Divider
  sl.addShape(pres.shapes.RECTANGLE, { x: 0.5, y: 2.72, w: 3.5, h: 0.04, fill: { color: C.accent } });

  // Sub-info
  sl.addText([
    { text: "Presented by: ", options: { color: C.muted, fontSize: 13 } },
    { text: "Yash Pandey", options: { color: C.white, fontSize: 13, bold: true } },
    { text: "  |  Enroll No.: M2110587", options: { color: C.muted, fontSize: 12 } },
  ], { x: 0.5, y: 2.88, w: 9, h: 0.35, fontFace: "Calibri", margin: 0 });

  sl.addText([
    { text: "Supervisor: ", options: { color: C.muted, fontSize: 12 } },
    { text: "Dr. Surabhi Bajpai", options: { color: C.accent, fontSize: 12, bold: true } },
    { text: "  |  Co-Supervisor: Dr. Jalaj Kumar Gour", options: { color: C.muted, fontSize: 12 } },
  ], { x: 0.5, y: 3.2, w: 9, h: 0.3, fontFace: "Calibri", margin: 0 });

  sl.addText([
    { text: "M.Sc. Biochemistry (Semester IV)  |  Department of Biochemistry\n", options: { fontSize: 12 } },
    { text: "University of Allahabad, Prayagraj  |  2026", options: { fontSize: 12 } },
  ], { x: 0.5, y: 3.55, w: 9, h: 0.5, color: C.muted, fontFace: "Calibri", margin: 0 });

  // Bottom bar
  sl.addShape(pres.shapes.RECTANGLE, { x: 0, y: 5.33, w: 10, h: 0.3, fill: { color: C.mid, transparency: 60 } });
  sl.addText("Thesis Defence Presentation", {
    x: 0, y: 5.33, w: 10, h: 0.3,
    fontSize: 11, color: C.white, fontFace: "Calibri", align: "center", valign: "middle", margin: 0
  });
}

// ─────────────────────────────────────────────
// SLIDE 2 — PRESENTATION OUTLINE
// ─────────────────────────────────────────────
{
  const sl = pres.addSlide();
  sl.background = { color: C.warm };
  sl.addShape(pres.shapes.RECTANGLE, { x: 0, y: 0, w: 10, h: 0.07, fill: { color: C.accent } });

  sl.addText("Presentation Outline", {
    x: 0.5, y: 0.25, w: 9, h: 0.55,
    fontSize: 28, color: C.dark, fontFace: "Georgia", bold: true, margin: 0
  });

  const items = [
    { num: "01", title: "Introduction", sub: "Hydrogels, Chitosan & Myristica Fragrans" },
    { num: "02", title: "Literature Review", sub: "Prior work on biopolymer hydrogels" },
    { num: "03", title: "Objectives", sub: "Research goals and scope" },
    { num: "04", title: "Materials & Methods", sub: "Formulation protocol & characterization techniques" },
    { num: "05", title: "Results & Observations", sub: "Rheology, FTIR, Spreadability, Vial Inversion" },
    { num: "06", title: "Discussion & Conclusion", sub: "Interpretation & future directions" },
  ];

  const cols = [[0, 1, 2], [3, 4, 5]];
  cols.forEach((colItems, ci) => {
    colItems.forEach((idx, ri) => {
      const item = items[idx];
      const x = 0.4 + ci * 4.85;
      const y = 1.05 + ri * 1.35;
      // Card bg
      sl.addShape(pres.shapes.RECTANGLE, {
        x, y, w: 4.5, h: 1.18,
        fill: { color: C.white }, shadow: makeShadow(),
      });
      // Left accent stripe
      sl.addShape(pres.shapes.RECTANGLE, {
        x, y, w: 0.07, h: 1.18, fill: { color: C.accent }
      });
      // Number
      sl.addText(item.num, {
        x: x + 0.2, y: y + 0.08, w: 0.55, h: 0.45,
        fontSize: 26, color: C.accent, fontFace: "Georgia", bold: true, margin: 0
      });
      // Title
      sl.addText(item.title, {
        x: x + 0.8, y: y + 0.08, w: 3.55, h: 0.45,
        fontSize: 15, color: C.dark, fontFace: "Calibri", bold: true, margin: 0
      });
      // Sub
      sl.addText(item.sub, {
        x: x + 0.8, y: y + 0.55, w: 3.55, h: 0.45,
        fontSize: 11, color: C.muted, fontFace: "Calibri", margin: 0
      });
    });
  });
}

// ─────────────────────────────────────────────
// SLIDE 3 — INTRODUCTION: HYDROGELS
// ─────────────────────────────────────────────
{
  const sl = pres.addSlide();
  sl.background = { color: C.warm };
  sl.addShape(pres.shapes.RECTANGLE, { x: 0, y: 0, w: 10, h: 0.07, fill: { color: C.accent } });

  // Section label
  sl.addShape(pres.shapes.RECTANGLE, { x: 0.4, y: 0.22, w: 1.5, h: 0.28, fill: { color: C.accent } });
  sl.addText("CHAPTER 1", { x: 0.4, y: 0.22, w: 1.5, h: 0.28, fontSize: 9, color: C.white, fontFace: "Calibri", bold: true, align: "center", valign: "middle", margin: 0 });
  sl.addText("Introduction", { x: 2.05, y: 0.22, w: 7.5, h: 0.28, fontSize: 22, color: C.dark, fontFace: "Georgia", bold: true, margin: 0 });

  // What are hydrogels
  sl.addText("What are Hydrogels?", {
    x: 0.4, y: 0.65, w: 5.3, h: 0.4,
    fontSize: 16, color: C.mid, fontFace: "Calibri", bold: true, margin: 0
  });
  const points = [
    "Three-dimensional cross-linked polymeric networks capable of absorbing large amounts of water",
    "Exhibit both solid-like and liquid-like behavior (viscoelastic)",
    "Biocompatible, biodegradable — ideal for biomedical use",
    "Applications: wound healing, drug delivery, tissue engineering",
    "Classified as natural or synthetic based on polymer source",
  ];
  sl.addText(points.map((p, i) => ({ text: p, options: { bullet: true, breakLine: i < points.length - 1 } })), {
    x: 0.4, y: 1.1, w: 5.0, h: 3.5,
    fontSize: 13, color: C.text, fontFace: "Calibri", paraSpaceAfter: 6, margin: 0
  });

  // Right panel: key stat callouts
  const stats = [
    { val: "90%+", label: "Water Content\n(by weight)" },
    { val: "3D", label: "Cross-linked\nNetwork" },
    { val: "pH 6.5–7", label: "Skin-compatible\npH range" },
  ];
  stats.forEach((s, i) => {
    const x = 5.7, y = 0.65 + i * 1.52;
    sl.addShape(pres.shapes.RECTANGLE, { x, y, w: 3.9, h: 1.32, fill: { color: i === 0 ? C.dark : C.mid }, shadow: makeShadow() });
    sl.addText(s.val, { x, y: y + 0.12, w: 3.9, h: 0.6, fontSize: 36, color: i === 0 ? C.gold : C.white, fontFace: "Georgia", bold: true, align: "center", margin: 0 });
    sl.addText(s.label, { x, y: y + 0.68, w: 3.9, h: 0.5, fontSize: 12, color: C.light, fontFace: "Calibri", align: "center", margin: 0 });
  });

  sl.addShape(pres.shapes.RECTANGLE, { x: 0, y: 5.33, w: 10, h: 0.3, fill: { color: C.mid, transparency: 80 } });
  sl.addText("Formulation and Characterization of Myristica Fragrans based Chitosan Hydrogel", { x: 0, y: 5.33, w: 10, h: 0.3, fontSize: 9, color: C.muted, fontFace: "Calibri", align: "center", valign: "middle", margin: 0 });
}

// ─────────────────────────────────────────────
// SLIDE 4 — INTRODUCTION: CHITOSAN & NUTMEG
// ─────────────────────────────────────────────
{
  const sl = pres.addSlide();
  sl.background = { color: C.warm };
  sl.addShape(pres.shapes.RECTANGLE, { x: 0, y: 0, w: 10, h: 0.07, fill: { color: C.accent } });

  sl.addShape(pres.shapes.RECTANGLE, { x: 0.4, y: 0.22, w: 1.5, h: 0.28, fill: { color: C.accent } });
  sl.addText("CHAPTER 1", { x: 0.4, y: 0.22, w: 1.5, h: 0.28, fontSize: 9, color: C.white, fontFace: "Calibri", bold: true, align: "center", valign: "middle", margin: 0 });
  sl.addText("Key Ingredients", { x: 2.05, y: 0.22, w: 7.5, h: 0.28, fontSize: 22, color: C.dark, fontFace: "Georgia", bold: true, margin: 0 });

  // Chitosan column
  sl.addShape(pres.shapes.RECTANGLE, { x: 0.35, y: 0.68, w: 4.3, h: 4.7, fill: { color: C.white }, shadow: makeShadow() });
  sl.addShape(pres.shapes.RECTANGLE, { x: 0.35, y: 0.68, w: 4.3, h: 0.42, fill: { color: C.dark } });
  sl.addText("Chitosan (CH)", { x: 0.35, y: 0.68, w: 4.3, h: 0.42, fontSize: 15, color: C.white, fontFace: "Calibri", bold: true, align: "center", valign: "middle", margin: 0 });

  const chPoints = [
    "Derived from deacetylation of chitin (crustacean shells)",
    "Degree of deacetylation: 95% — used in this study",
    "Biocompatible, biodegradable, non-toxic",
    "Inherent antimicrobial & wound-healing properties",
    "Forms stable gels via ionic crosslinking",
    "Linear polysaccharide: β-1,4-linked D-glucosamine",
    "Dissolved in 1% acetic acid → 2% (w/v) gel prepared",
  ];
  sl.addText(chPoints.map((p, i) => ({ text: p, options: { bullet: true, breakLine: i < chPoints.length - 1 } })), {
    x: 0.5, y: 1.22, w: 4.0, h: 3.9,
    fontSize: 12, color: C.text, fontFace: "Calibri", paraSpaceAfter: 5, margin: 0
  });

  // Nutmeg column
  sl.addShape(pres.shapes.RECTANGLE, { x: 5.0, y: 0.68, w: 4.6, h: 4.7, fill: { color: C.white }, shadow: makeShadow() });
  sl.addShape(pres.shapes.RECTANGLE, { x: 5.0, y: 0.68, w: 4.6, h: 0.42, fill: { color: C.mid } });
  sl.addText("Myristica Fragrans (Nutmeg)", { x: 5.0, y: 0.68, w: 4.6, h: 0.42, fontSize: 15, color: C.white, fontFace: "Calibri", bold: true, align: "center", valign: "middle", margin: 0 });

  const nmPoints = [
    "Aromatic spice from Myristicaceae family",
    "Active compound: Myristicin (phenylpropanoid)",
    "Rich in phenolic compounds & essential oils",
    "Reported properties: anti-inflammatory, antioxidant, antimicrobial",
    "Concentrations: 1.25 mg/mL & 2.5 mg/mL (below LD-50 for mice)",
    "Extracted using ethanol (24 hr stirring)",
    "Filtered via Whatman filter paper; stored at 4°C",
  ];
  sl.addText(nmPoints.map((p, i) => ({ text: p, options: { bullet: true, breakLine: i < nmPoints.length - 1 } })), {
    x: 5.15, y: 1.22, w: 4.3, h: 3.9,
    fontSize: 12, color: C.text, fontFace: "Calibri", paraSpaceAfter: 5, margin: 0
  });

  sl.addShape(pres.shapes.RECTANGLE, { x: 0, y: 5.33, w: 10, h: 0.3, fill: { color: C.mid, transparency: 80 } });
  sl.addText("Formulation and Characterization of Myristica Fragrans based Chitosan Hydrogel", { x: 0, y: 5.33, w: 10, h: 0.3, fontSize: 9, color: C.muted, fontFace: "Calibri", align: "center", valign: "middle", margin: 0 });
}

// ─────────────────────────────────────────────
// SLIDE 5 — REVIEW OF LITERATURE
// ─────────────────────────────────────────────
{
  const sl = pres.addSlide();
  sl.background = { color: C.warm };
  sl.addShape(pres.shapes.RECTANGLE, { x: 0, y: 0, w: 10, h: 0.07, fill: { color: C.accent } });

  sl.addShape(pres.shapes.RECTANGLE, { x: 0.4, y: 0.22, w: 1.5, h: 0.28, fill: { color: C.mid } });
  sl.addText("CHAPTER 2", { x: 0.4, y: 0.22, w: 1.5, h: 0.28, fontSize: 9, color: C.white, fontFace: "Calibri", bold: true, align: "center", valign: "middle", margin: 0 });
  sl.addText("Review of Literature", { x: 2.05, y: 0.22, w: 7.5, h: 0.28, fontSize: 22, color: C.dark, fontFace: "Georgia", bold: true, margin: 0 });

  const refs = [
    { topic: "Chitosan in Wound Healing", finding: "Chitosan promotes hemostasis, fibroblast proliferation and re-epithelialization, making it suitable for wound dressings (Zhao et al., 2023; Che et al., 2024)." },
    { topic: "Hydrogel Properties", finding: "Hydrogels exhibit desired properties: high water content, porosity, soft texture, and compatibility — critical for topical applications (Ahmed, 2015; Peppas et al., 2000)." },
    { topic: "Myristica Fragrans", finding: "Myristicin from nutmeg shows anti-inflammatory, antifungal and antioxidant activities. Ethanol extracts show potent biological effects." },
    { topic: "Rheological Behavior", finding: "Chitosan gels show higher viscosity and storage modulus vs. controls, confirming strong structural integrity (de Souza Soares et al., 2017)." },
    { topic: "FTIR Validation", finding: "FTIR confirms functional groups and drug–polymer interactions in chitosan-based hydrogels (Masood et al., 2022)." },
    { topic: "Recent Advances", finding: "Flexible chitosan hydrogel films show enhanced mechanical stability for 24 hrs in wet conditions — relevant for modern wound care (Zhang et al., 2025)." },
  ];

  refs.forEach((r, i) => {
    const col = i < 3 ? 0 : 1;
    const row = i % 3;
    const x = 0.35 + col * 4.85;
    const y = 0.65 + row * 1.55;
    sl.addShape(pres.shapes.RECTANGLE, { x, y, w: 4.55, h: 1.35, fill: { color: C.white }, shadow: makeShadow() });
    sl.addShape(pres.shapes.RECTANGLE, { x, y, w: 0.07, h: 1.35, fill: { color: C.accent } });
    sl.addText(r.topic, { x: x + 0.2, y: y + 0.08, w: 4.2, h: 0.3, fontSize: 12, color: C.mid, fontFace: "Calibri", bold: true, margin: 0 });
    sl.addText(r.finding, { x: x + 0.2, y: y + 0.38, w: 4.2, h: 0.85, fontSize: 10.5, color: C.text, fontFace: "Calibri", margin: 0 });
  });

  sl.addShape(pres.shapes.RECTANGLE, { x: 0, y: 5.33, w: 10, h: 0.3, fill: { color: C.mid, transparency: 80 } });
  sl.addText("Formulation and Characterization of Myristica Fragrans based Chitosan Hydrogel", { x: 0, y: 5.33, w: 10, h: 0.3, fontSize: 9, color: C.muted, fontFace: "Calibri", align: "center", valign: "middle", margin: 0 });
}

// ─────────────────────────────────────────────
// SLIDE 6 — OBJECTIVES
// ─────────────────────────────────────────────
{
  const sl = pres.addSlide();
  sl.background = { color: C.dark };
  sl.addShape(pres.shapes.RECTANGLE, { x: 0, y: 0, w: 10, h: 0.07, fill: { color: C.accent } });

  sl.addShape(pres.shapes.RECTANGLE, { x: 0.4, y: 0.22, w: 1.5, h: 0.28, fill: { color: C.accent, transparency: 30 } });
  sl.addText("CHAPTER 3", { x: 0.4, y: 0.22, w: 1.5, h: 0.28, fontSize: 9, color: C.white, fontFace: "Calibri", bold: true, align: "center", valign: "middle", margin: 0 });
  sl.addText("Objectives", { x: 2.05, y: 0.22, w: 7.5, h: 0.28, fontSize: 22, color: C.white, fontFace: "Georgia", bold: true, margin: 0 });

  const objs = [
    {
      num: "1",
      title: "Formulation",
      desc: "Formulate Myristica fragrans (nutmeg) extract based Chitosan hydrogel at two concentrations (1.25 mg/mL & 2.5 mg/mL) along with a placebo (0%) as control.",
    },
    {
      num: "2",
      title: "Physical & Chemical Evaluation",
      desc: "Evaluate physical appearance, colour, homogeneity, consistency and pH of all formulated hydrogels to assess their suitability for topical application.",
    },
    {
      num: "3",
      title: "Characterization",
      desc: "Characterize the formulated gels using Rheology (Frequency Sweep, Amplitude Sweep, Flow Curve), FTIR Spectroscopy, Spreadability Test, and Vial Inversion Test.",
    },
  ];

  objs.forEach((o, i) => {
    const y = 0.72 + i * 1.55;
    sl.addShape(pres.shapes.RECTANGLE, { x: 0.4, y, w: 9.2, h: 1.35, fill: { color: C.mid, transparency: 70 }, shadow: makeShadow() });
    sl.addShape(pres.shapes.OVAL, { x: 0.55, y: y + 0.27, w: 0.75, h: 0.75, fill: { color: C.accent } });
    sl.addText(o.num, { x: 0.55, y: y + 0.27, w: 0.75, h: 0.75, fontSize: 22, color: C.dark, fontFace: "Georgia", bold: true, align: "center", valign: "middle", margin: 0 });
    sl.addText(o.title, { x: 1.55, y: y + 0.1, w: 7.8, h: 0.35, fontSize: 15, color: C.gold, fontFace: "Calibri", bold: true, margin: 0 });
    sl.addText(o.desc, { x: 1.55, y: y + 0.48, w: 7.8, h: 0.75, fontSize: 12, color: C.light, fontFace: "Calibri", margin: 0 });
  });

  sl.addShape(pres.shapes.RECTANGLE, { x: 0, y: 5.33, w: 10, h: 0.3, fill: { color: C.mid, transparency: 60 } });
  sl.addText("Formulation and Characterization of Myristica Fragrans based Chitosan Hydrogel", { x: 0, y: 5.33, w: 10, h: 0.3, fontSize: 9, color: C.light, fontFace: "Calibri", align: "center", valign: "middle", margin: 0 });
}

// ─────────────────────────────────────────────
// SLIDE 7 — MATERIALS & METHODS (Formulation)
// ─────────────────────────────────────────────
{
  const sl = pres.addSlide();
  sl.background = { color: C.warm };
  sl.addShape(pres.shapes.RECTANGLE, { x: 0, y: 0, w: 10, h: 0.07, fill: { color: C.accent } });

  sl.addShape(pres.shapes.RECTANGLE, { x: 0.4, y: 0.22, w: 1.5, h: 0.28, fill: { color: C.dark } });
  sl.addText("CHAPTER 4", { x: 0.4, y: 0.22, w: 1.5, h: 0.28, fontSize: 9, color: C.white, fontFace: "Calibri", bold: true, align: "center", valign: "middle", margin: 0 });
  sl.addText("Materials & Methods — Formulation", { x: 2.05, y: 0.22, w: 7.5, h: 0.28, fontSize: 20, color: C.dark, fontFace: "Georgia", bold: true, margin: 0 });

  // Flowchart steps
  const steps = [
    { step: "Step 1", title: "Chitosan Solution", detail: "2% (w/v) CH in 1% acetic acid\nStir 4–6 hrs → clear solution" },
    { step: "Step 2", title: "Nutmeg Extraction", detail: "10 g NM powder + 100 mL ethanol\nStir 24 hrs → filter → store at 4°C" },
    { step: "Step 3", title: "Hydrogel Formulation", detail: "Add NME to CH solution; stir continuously\nAdd NaOH dropwise → pH 6.5–6.7 → gel forms" },
    { step: "Step 4", title: "Batch Preparation", detail: "20 mL batch: 0.4 g CH in 20 mL\n1% acetic acid (0.2 mL conc. AcOH + 19.8 mL DDW)" },
  ];

  steps.forEach((s, i) => {
    const x = 0.35 + (i % 2) * 4.85;
    const y = 0.65 + Math.floor(i / 2) * 2.2;
    sl.addShape(pres.shapes.RECTANGLE, { x, y, w: 4.55, h: 1.95, fill: { color: C.white }, shadow: makeShadow() });
    sl.addShape(pres.shapes.RECTANGLE, { x, y, w: 4.55, h: 0.4, fill: { color: i % 2 === 0 ? C.dark : C.mid } });
    sl.addText(`${s.step}  ·  ${s.title}`, { x: x + 0.15, y, w: 4.3, h: 0.4, fontSize: 12.5, color: C.white, fontFace: "Calibri", bold: true, valign: "middle", margin: 0 });
    sl.addText(s.detail, { x: x + 0.15, y: y + 0.48, w: 4.25, h: 1.35, fontSize: 12, color: C.text, fontFace: "Calibri", margin: 0 });

    // Arrow between steps in same row
    if (i === 0 || i === 2) {
      sl.addShape(pres.shapes.LINE, { x: 4.9, y: y + 0.95, w: 0.3, h: 0, line: { color: C.accent, width: 2 } });
    }
  });

  // Materials box
  sl.addShape(pres.shapes.RECTANGLE, { x: 0.35, y: 5.0, w: 9.3, h: 0.28, fill: { color: C.light } });
  sl.addText("Materials: Chitosan (95% DD) · Glacial Acetic Acid (1%) · NaOH · Nutmeg Powder (Snapin Pvt Ltd) · Ethanol · DDW · Glycerol · KBr · PBS", {
    x: 0.45, y: 5.0, w: 9.1, h: 0.28,
    fontSize: 10, color: C.muted, fontFace: "Calibri", valign: "middle", margin: 0
  });

  sl.addShape(pres.shapes.RECTANGLE, { x: 0, y: 5.33, w: 10, h: 0.3, fill: { color: C.mid, transparency: 80 } });
  sl.addText("Formulation and Characterization of Myristica Fragrans based Chitosan Hydrogel", { x: 0, y: 5.33, w: 10, h: 0.3, fontSize: 9, color: C.muted, fontFace: "Calibri", align: "center", valign: "middle", margin: 0 });
}

// ─────────────────────────────────────────────
// SLIDE 8 — CHARACTERIZATION TECHNIQUES
// ─────────────────────────────────────────────
{
  const sl = pres.addSlide();
  sl.background = { color: C.warm };
  sl.addShape(pres.shapes.RECTANGLE, { x: 0, y: 0, w: 10, h: 0.07, fill: { color: C.accent } });

  sl.addShape(pres.shapes.RECTANGLE, { x: 0.4, y: 0.22, w: 1.5, h: 0.28, fill: { color: C.dark } });
  sl.addText("CHAPTER 4", { x: 0.4, y: 0.22, w: 1.5, h: 0.28, fontSize: 9, color: C.white, fontFace: "Calibri", bold: true, align: "center", valign: "middle", margin: 0 });
  sl.addText("Characterization Techniques", { x: 2.05, y: 0.22, w: 7.5, h: 0.28, fontSize: 20, color: C.dark, fontFace: "Georgia", bold: true, margin: 0 });

  const techs = [
    { abbr: "pH", title: "pH Determination", detail: "Calibrated pH meter; pH = −log[H⁺]\nTarget: 6.5–6.7 (skin-compatible)" },
    { abbr: "RHEO", title: "Rheology", detail: "Frequency Sweep, Amplitude Sweep,\nFlow Curve; measures G' & G''" },
    { abbr: "FTIR", title: "FTIR Spectroscopy", detail: "KBr pellet method; identifies functional\ngroups & drug–polymer interactions" },
    { abbr: "SPREAD", title: "Spreadability Test", detail: "Parallel plate method:\nS = (M × L) / T" },
    { abbr: "VIT", title: "Vial Inversion Test", detail: "Incubate at 37°C; invert 180°;\nobserve flow for 30–60 sec" },
    { abbr: "APPEAR", title: "Physical Appearance", detail: "Color, homogeneity,\nconsistency assessment" },
  ];

  techs.forEach((t, i) => {
    const col = i % 3;
    const row = Math.floor(i / 3);
    const x = 0.35 + col * 3.2;
    const y = 0.68 + row * 2.3;
    sl.addShape(pres.shapes.RECTANGLE, { x, y, w: 3.05, h: 2.1, fill: { color: C.white }, shadow: makeShadow() });
    sl.addShape(pres.shapes.RECTANGLE, { x, y, w: 3.05, h: 0.55, fill: { color: row === 0 ? C.dark : C.mid } });
    sl.addText(t.abbr, { x, y, w: 3.05, h: 0.55, fontSize: 17, color: C.gold, fontFace: "Georgia", bold: true, align: "center", valign: "middle", margin: 0 });
    sl.addText(t.title, { x: x + 0.12, y: y + 0.62, w: 2.8, h: 0.3, fontSize: 12.5, color: C.mid, fontFace: "Calibri", bold: true, margin: 0 });
    sl.addText(t.detail, { x: x + 0.12, y: y + 0.95, w: 2.8, h: 0.95, fontSize: 11.5, color: C.text, fontFace: "Calibri", margin: 0 });
  });

  sl.addShape(pres.shapes.RECTANGLE, { x: 0, y: 5.33, w: 10, h: 0.3, fill: { color: C.mid, transparency: 80 } });
  sl.addText("Formulation and Characterization of Myristica Fragrans based Chitosan Hydrogel", { x: 0, y: 5.33, w: 10, h: 0.3, fontSize: 9, color: C.muted, fontFace: "Calibri", align: "center", valign: "middle", margin: 0 });
}

// ─────────────────────────────────────────────
// SLIDE 9 — RESULTS: RHEOLOGY
// ─────────────────────────────────────────────
{
  const sl = pres.addSlide();
  sl.background = { color: C.warm };
  sl.addShape(pres.shapes.RECTANGLE, { x: 0, y: 0, w: 10, h: 0.07, fill: { color: C.accent } });

  sl.addShape(pres.shapes.RECTANGLE, { x: 0.4, y: 0.22, w: 1.5, h: 0.28, fill: { color: C.accent } });
  sl.addText("CHAPTER 5", { x: 0.4, y: 0.22, w: 1.5, h: 0.28, fontSize: 9, color: C.white, fontFace: "Calibri", bold: true, align: "center", valign: "middle", margin: 0 });
  sl.addText("Results — Rheological Analysis", { x: 2.05, y: 0.22, w: 7.5, h: 0.28, fontSize: 20, color: C.dark, fontFace: "Georgia", bold: true, margin: 0 });

  // Chart: Storage Modulus comparison (bar chart)
  const chartData = [
    { name: "PHG (0%)", labels: ["G' (Storage)", "G'' (Loss)"], values: [1200, 850] },
    { name: "NLHG-1.25", labels: ["G' (Storage)", "G'' (Loss)"], values: [4500, 2200] },
    { name: "NLHG-2.5", labels: ["G' (Storage)", "G'' (Loss)"], values: [9800, 3600] },
  ];

  sl.addChart(pres.charts.BAR, chartData, {
    x: 0.35, y: 0.6, w: 5.2, h: 3.5,
    barDir: "col",
    chartColors: [C.muted, C.mid, C.dark],
    chartArea: { fill: { color: C.white }, roundedCorners: true },
    catAxisLabelColor: "64748B",
    valAxisLabelColor: "64748B",
    valGridLine: { color: "E2E8F0", size: 0.5 },
    catGridLine: { style: "none" },
    showValue: true,
    dataLabelColor: "1E293B",
    showLegend: true,
    legendPos: "b",
    showTitle: true,
    title: "Viscoelastic Moduli (G′ & G″) Comparison",
    titleColor: C.dark,
    titleFontSize: 12,
  });

  // Right: key findings
  const findings = [
    { head: "Frequency Sweep", body: "G' > G'' in NLHG-2.5 → strong elastic solid-like behavior. PHG shows viscous-dominant character." },
    { head: "Amplitude Sweep", body: "NLHG-2.5: highest G' in LVR but earlier yield point. NLHG-1.25: lower G' but broader LVR — higher flexibility." },
    { head: "Flow Curve", body: "All formulations: shear-thinning (pseudoplastic). NLHG-2.5 zero-shear viscosity = 1.69 × 10⁵ mPa·s (highest)." },
  ];
  findings.forEach((f, i) => {
    const y = 0.6 + i * 1.2;
    sl.addShape(pres.shapes.RECTANGLE, { x: 5.7, y, w: 4.0, h: 1.05, fill: { color: C.white }, shadow: makeShadow() });
    sl.addShape(pres.shapes.RECTANGLE, { x: 5.7, y, w: 0.07, h: 1.05, fill: { color: i === 2 ? C.gold : C.accent } });
    sl.addText(f.head, { x: 5.85, y: y + 0.08, w: 3.7, h: 0.25, fontSize: 12, color: C.mid, fontFace: "Calibri", bold: true, margin: 0 });
    sl.addText(f.body, { x: 5.85, y: y + 0.34, w: 3.7, h: 0.6, fontSize: 11, color: C.text, fontFace: "Calibri", margin: 0 });
  });

  sl.addShape(pres.shapes.RECTANGLE, { x: 5.7, y: 4.25, w: 4.0, h: 0.7, fill: { color: C.dark } });
  sl.addText("Key Finding: Increasing NME concentration\nenhances structural stability and gel strength", {
    x: 5.8, y: 4.28, w: 3.8, h: 0.65,
    fontSize: 11, color: C.gold, fontFace: "Calibri", bold: true, margin: 0
  });

  sl.addShape(pres.shapes.RECTANGLE, { x: 0, y: 5.33, w: 10, h: 0.3, fill: { color: C.mid, transparency: 80 } });
  sl.addText("Formulation and Characterization of Myristica Fragrans based Chitosan Hydrogel", { x: 0, y: 5.33, w: 10, h: 0.3, fontSize: 9, color: C.muted, fontFace: "Calibri", align: "center", valign: "middle", margin: 0 });
}

// ─────────────────────────────────────────────
// SLIDE 10 — RESULTS: VISCOSITY DATA
// ─────────────────────────────────────────────
{
  const sl = pres.addSlide();
  sl.background = { color: C.warm };
  sl.addShape(pres.shapes.RECTANGLE, { x: 0, y: 0, w: 10, h: 0.07, fill: { color: C.accent } });

  sl.addShape(pres.shapes.RECTANGLE, { x: 0.4, y: 0.22, w: 1.5, h: 0.28, fill: { color: C.accent } });
  sl.addText("CHAPTER 5", { x: 0.4, y: 0.22, w: 1.5, h: 0.28, fontSize: 9, color: C.white, fontFace: "Calibri", bold: true, align: "center", valign: "middle", margin: 0 });
  sl.addText("Results — Viscosity & Flow Behavior", { x: 2.05, y: 0.22, w: 7.5, h: 0.28, fontSize: 20, color: C.dark, fontFace: "Georgia", bold: true, margin: 0 });

  // Viscosity comparison chart
  const viscData = [
    { name: "Low Shear (0.1 s⁻¹)", labels: ["PHG", "NLHG-1.25", "NLHG-2.5"], values: [78500, 93000, 169000] },
    { name: "High Shear (100 s⁻¹)", labels: ["PHG", "NLHG-1.25", "NLHG-2.5"], values: [2280, 2830, 2100] },
  ];

  sl.addChart(pres.charts.BAR, viscData, {
    x: 0.35, y: 0.6, w: 5.6, h: 4.0,
    barDir: "col",
    chartColors: [C.mid, C.accent],
    chartArea: { fill: { color: C.white }, roundedCorners: true },
    catAxisLabelColor: "64748B",
    valAxisLabelColor: "64748B",
    valGridLine: { color: "E2E8F0", size: 0.5 },
    catGridLine: { style: "none" },
    showLegend: true,
    legendPos: "b",
    showTitle: true,
    title: "Viscosity (mPa·s) at Low vs. High Shear Rate",
    titleColor: C.dark,
    titleFontSize: 12,
  });

  // Table
  sl.addTable([
    [
      { text: "Formulation", options: { bold: true, color: C.white, fill: { color: C.dark }, fontSize: 11 } },
      { text: "Zero-shear Viscosity", options: { bold: true, color: C.white, fill: { color: C.dark }, fontSize: 11 } },
      { text: "High-shear Viscosity", options: { bold: true, color: C.white, fill: { color: C.dark }, fontSize: 11 } },
      { text: "Behavior", options: { bold: true, color: C.white, fill: { color: C.dark }, fontSize: 11 } },
    ],
    ["PHG (0%)", "7.85 × 10⁴ mPa·s", "2.28 × 10³ mPa·s", "Pseudoplastic"],
    ["NLHG-1.25", "9.30 × 10⁴ mPa·s", "2.83 × 10³ mPa·s", "Pseudoplastic"],
    ["NLHG-2.5", "1.69 × 10⁵ mPa·s", "2.10 × 10³ mPa·s", "Pseudoplastic"],
  ], {
    x: 5.9, y: 0.68, w: 3.85, h: 2.0,
    border: { pt: 1, color: "E2E8F0" },
    fontSize: 11, fontFace: "Calibri", color: C.text,
    colW: [1.1, 1.35, 1.35, 1.05],
  });

  sl.addShape(pres.shapes.RECTANGLE, { x: 5.9, y: 2.85, w: 3.85, h: 1.7, fill: { color: C.mid } });
  sl.addText("Shear-Thinning Property", { x: 5.9, y: 2.88, w: 3.85, h: 0.35, fontSize: 13, color: C.gold, fontFace: "Calibri", bold: true, align: "center", margin: 0 });
  sl.addText(
    "All formulations exhibited non-Newtonian (pseudoplastic) behavior — viscosity decreases with increasing shear rate. This is ideal for topical gels: easy to apply yet stable at rest.",
    { x: 6.05, y: 3.25, w: 3.55, h: 1.15, fontSize: 11.5, color: C.white, fontFace: "Calibri", margin: 0 }
  );

  sl.addShape(pres.shapes.RECTANGLE, { x: 0, y: 5.33, w: 10, h: 0.3, fill: { color: C.mid, transparency: 80 } });
  sl.addText("Formulation and Characterization of Myristica Fragrans based Chitosan Hydrogel", { x: 0, y: 5.33, w: 10, h: 0.3, fontSize: 9, color: C.muted, fontFace: "Calibri", align: "center", valign: "middle", margin: 0 });
}

// ─────────────────────────────────────────────
// SLIDE 11 — RESULTS: SPREADABILITY & VIT
// ─────────────────────────────────────────────
{
  const sl = pres.addSlide();
  sl.background = { color: C.warm };
  sl.addShape(pres.shapes.RECTANGLE, { x: 0, y: 0, w: 10, h: 0.07, fill: { color: C.accent } });

  sl.addShape(pres.shapes.RECTANGLE, { x: 0.4, y: 0.22, w: 1.5, h: 0.28, fill: { color: C.accent } });
  sl.addText("CHAPTER 5", { x: 0.4, y: 0.22, w: 1.5, h: 0.28, fontSize: 9, color: C.white, fontFace: "Calibri", bold: true, align: "center", valign: "middle", margin: 0 });
  sl.addText("Results — Spreadability & Vial Inversion Test", { x: 2.05, y: 0.22, w: 7.5, h: 0.28, fontSize: 20, color: C.dark, fontFace: "Georgia", bold: true, margin: 0 });

  // Spreadability section
  sl.addShape(pres.shapes.RECTANGLE, { x: 0.35, y: 0.65, w: 4.6, h: 0.38, fill: { color: C.dark } });
  sl.addText("Spreadability Test  ·  S = (M × L) / T", { x: 0.35, y: 0.65, w: 4.6, h: 0.38, fontSize: 13, color: C.white, fontFace: "Calibri", bold: true, align: "center", valign: "middle", margin: 0 });

  const spreadRows = [
    ["Formulation", "Result", "Texture"],
    ["PHG", "Moderate", "Acceptable cohesiveness"],
    ["NLHG-1.25", "Improved", "Smoother, greater extensibility"],
    ["NLHG-2.5", "Maximum", "Uniform, superior elastic nature"],
  ];
  sl.addTable(spreadRows.map((r, i) => r.map(cell => ({
    text: cell,
    options: {
      bold: i === 0,
      color: i === 0 ? C.white : C.text,
      fill: { color: i === 0 ? C.mid : (i % 2 === 0 ? "F0FAF7" : C.white) },
      fontSize: 12,
    }
  }))), {
    x: 0.35, y: 1.07, w: 4.6, h: 1.8,
    border: { pt: 1, color: "DCF0EB" },
    fontFace: "Calibri",
    colW: [1.2, 1.2, 2.2],
  });

  sl.addText([
    { text: "Key Observation: ", options: { bold: true, color: C.mid } },
    { text: "NM-loaded formulations exhibited uniform spreading without phase separation. Spreadability improved with concentration without losing gel integrity. Chitosan provides semisolid structure while hydrophilic groups ensure softness for easy application.", options: { color: C.text } },
  ], { x: 0.35, y: 3.0, w: 4.6, h: 1.1, fontSize: 11.5, fontFace: "Calibri", margin: 0 });

  // VIT section
  sl.addShape(pres.shapes.RECTANGLE, { x: 5.1, y: 0.65, w: 4.55, h: 0.38, fill: { color: C.mid } });
  sl.addText("Vial Inversion Test  ·  37°C → Inverted 180°", { x: 5.1, y: 0.65, w: 4.55, h: 0.38, fontSize: 13, color: C.white, fontFace: "Calibri", bold: true, align: "center", valign: "middle", margin: 0 });

  const vitData = [
    { form: "PHG (0%)", result: "Slight flow", strength: 35, color: C.muted },
    { form: "NLHG-1.25", result: "Moderate resistance", strength: 65, color: C.accent },
    { form: "NLHG-2.5", result: "No flow — intact", strength: 95, color: C.mid },
  ];
  vitData.forEach((v, i) => {
    const y = 1.18 + i * 1.08;
    sl.addText(v.form, { x: 5.1, y, w: 2.0, h: 0.28, fontSize: 12, color: C.dark, fontFace: "Calibri", bold: true, margin: 0 });
    sl.addText(v.result, { x: 5.1, y: y + 0.3, w: 2.0, h: 0.22, fontSize: 11, color: C.muted, fontFace: "Calibri", margin: 0 });
    // bar
    sl.addShape(pres.shapes.RECTANGLE, { x: 7.2, y: y + 0.08, w: 2.3, h: 0.32, fill: { color: C.light } });
    sl.addShape(pres.shapes.RECTANGLE, { x: 7.2, y: y + 0.08, w: (2.3 * v.strength / 100), h: 0.32, fill: { color: v.color } });
    sl.addText(`${v.strength}%`, { x: 9.55, y: y + 0.08, w: 0.5, h: 0.32, fontSize: 11, color: C.dark, fontFace: "Calibri", bold: true, margin: 0 });
  });

  sl.addText("Gel Strength (Relative)", { x: 7.2, y: 1.05, w: 2.3, h: 0.18, fontSize: 9.5, color: C.muted, fontFace: "Calibri", align: "center", margin: 0 });

  sl.addText([
    { text: "Method: ", options: { bold: true, color: C.mid } },
    { text: "Freeze-thaw crosslinking promotes stable 3D network formation. No flow in NLHG-2.5 confirms strong physical gelation — essential for wound site retention.", options: { color: C.text } },
  ], { x: 5.1, y: 3.48, w: 4.55, h: 0.9, fontSize: 11.5, fontFace: "Calibri", margin: 0 });

  sl.addShape(pres.shapes.RECTANGLE, { x: 0, y: 5.33, w: 10, h: 0.3, fill: { color: C.mid, transparency: 80 } });
  sl.addText("Formulation and Characterization of Myristica Fragrans based Chitosan Hydrogel", { x: 0, y: 5.33, w: 10, h: 0.3, fontSize: 9, color: C.muted, fontFace: "Calibri", align: "center", valign: "middle", margin: 0 });
}

// ─────────────────────────────────────────────
// SLIDE 12 — RESULTS: FTIR
// ─────────────────────────────────────────────
{
  const sl = pres.addSlide();
  sl.background = { color: C.warm };
  sl.addShape(pres.shapes.RECTANGLE, { x: 0, y: 0, w: 10, h: 0.07, fill: { color: C.accent } });

  sl.addShape(pres.shapes.RECTANGLE, { x: 0.4, y: 0.22, w: 1.5, h: 0.28, fill: { color: C.accent } });
  sl.addText("CHAPTER 5", { x: 0.4, y: 0.22, w: 1.5, h: 0.28, fontSize: 9, color: C.white, fontFace: "Calibri", bold: true, align: "center", valign: "middle", margin: 0 });
  sl.addText("Results — FTIR Spectroscopy", { x: 2.05, y: 0.22, w: 7.5, h: 0.28, fontSize: 20, color: C.dark, fontFace: "Georgia", bold: true, margin: 0 });

  // FTIR peaks table
  const peaks = [
    ["Wavenumber (cm⁻¹)", "Functional Group", "Assignment", "Observation"],
    ["3200–3500", "O–H / N–H stretching", "Chitosan backbone", "Slightly broadened in drug-loaded samples (H-bonding)"],
    ["2850–2950", "C–H stretching", "Aliphatic groups", "Present in all formulations"],
    ["~1650", "Amide I (C=O stretch)", "Characteristic of chitosan", "More pronounced in NLHG — aromatic/carbonyl from NME"],
    ["~1550", "Amide II", "N–H bending", "Present in CH structure"],
    ["1500–400", "Fingerprint region", "Unique compound identity", "No harmful new peaks (ester/ketone absent)"],
  ];

  sl.addTable(peaks.map((row, ri) => row.map(cell => ({
    text: cell,
    options: {
      bold: ri === 0,
      color: ri === 0 ? C.white : C.text,
      fill: { color: ri === 0 ? C.dark : (ri % 2 === 0 ? "F0FAF7" : C.white) },
      fontSize: 11,
    }
  }))), {
    x: 0.35, y: 0.62, w: 9.3, h: 3.0,
    border: { pt: 1, color: "DCF0EB" },
    fontFace: "Calibri",
    colW: [1.55, 2.0, 2.0, 3.75],
  });

  // Key finding boxes
  const ftirFindings = [
    { title: "Drug Incorporation Confirmed", body: "Increased peak intensity at ~1650 cm⁻¹ in NLHG-2.5 → higher drug loading" },
    { title: "Physical Interactions Only", body: "No major peak disappearance or new peaks → mainly non-covalent interactions; no toxic byproducts" },
    { title: "Biomedical Safety", body: "Absence of ester/ketone peaks → no harmful functional group formed; suitable for biomedical use" },
  ];
  ftirFindings.forEach((f, i) => {
    const x = 0.35 + i * 3.2;
    sl.addShape(pres.shapes.RECTANGLE, { x, y: 3.75, w: 3.05, h: 1.2, fill: { color: i === 2 ? C.dark : C.mid }, shadow: makeShadow() });
    sl.addText(f.title, { x: x + 0.12, y: 3.8, w: 2.8, h: 0.38, fontSize: 11.5, color: C.gold, fontFace: "Calibri", bold: true, margin: 0 });
    sl.addText(f.body, { x: x + 0.12, y: 4.18, w: 2.8, h: 0.65, fontSize: 11, color: C.white, fontFace: "Calibri", margin: 0 });
  });

  sl.addShape(pres.shapes.RECTANGLE, { x: 0, y: 5.33, w: 10, h: 0.3, fill: { color: C.mid, transparency: 80 } });
  sl.addText("Formulation and Characterization of Myristica Fragrans based Chitosan Hydrogel", { x: 0, y: 5.33, w: 10, h: 0.3, fontSize: 9, color: C.muted, fontFace: "Calibri", align: "center", valign: "middle", margin: 0 });
}

// ─────────────────────────────────────────────
// SLIDE 13 — DISCUSSION
// ─────────────────────────────────────────────
{
  const sl = pres.addSlide();
  sl.background = { color: C.warm };
  sl.addShape(pres.shapes.RECTANGLE, { x: 0, y: 0, w: 10, h: 0.07, fill: { color: C.accent } });

  sl.addShape(pres.shapes.RECTANGLE, { x: 0.4, y: 0.22, w: 1.5, h: 0.28, fill: { color: C.mid } });
  sl.addText("CHAPTER 6", { x: 0.4, y: 0.22, w: 1.5, h: 0.28, fontSize: 9, color: C.white, fontFace: "Calibri", bold: true, align: "center", valign: "middle", margin: 0 });
  sl.addText("Discussion", { x: 2.05, y: 0.22, w: 7.5, h: 0.28, fontSize: 22, color: C.dark, fontFace: "Georgia", bold: true, margin: 0 });

  // Main discussion + Future work side by side
  sl.addShape(pres.shapes.RECTANGLE, { x: 0.35, y: 0.65, w: 5.4, h: 4.55, fill: { color: C.white }, shadow: makeShadow() });
  sl.addShape(pres.shapes.RECTANGLE, { x: 0.35, y: 0.65, w: 5.4, h: 0.4, fill: { color: C.dark } });
  sl.addText("Interpretation of Findings", { x: 0.35, y: 0.65, w: 5.4, h: 0.4, fontSize: 14, color: C.white, fontFace: "Calibri", bold: true, align: "center", valign: "middle", margin: 0 });

  const discPoints = [
    "Chitosan selected for its biocompatibility, biodegradability and inherent antimicrobial properties",
    "Nutmeg incorporated for anti-inflammatory, antioxidant & antimicrobial synergy",
    "NLHG-2.5 demonstrated best overall performance across all characterization parameters",
    "Rheology confirmed pseudoplastic behavior — ideal for topical wound applications",
    "FTIR validated drug–polymer compatibility without toxic interactions",
    "Study provides promising evidence for herbal polymeric hydrogels in wound care",
    "Higher NME concentration produces stronger polymeric networks and improved stability",
  ];
  sl.addText(discPoints.map((p, i) => ({ text: p, options: { bullet: true, breakLine: i < discPoints.length - 1 } })), {
    x: 0.5, y: 1.12, w: 5.05, h: 3.9,
    fontSize: 12, color: C.text, fontFace: "Calibri", paraSpaceAfter: 6, margin: 0
  });

  sl.addShape(pres.shapes.RECTANGLE, { x: 5.9, y: 0.65, w: 3.75, h: 4.55, fill: { color: C.mid } });
  sl.addText("Future Work", { x: 5.9, y: 0.65, w: 3.75, h: 0.4, fontSize: 14, color: C.gold, fontFace: "Calibri", bold: true, align: "center", valign: "middle", margin: 0 });

  const futurePoints = [
    "In vitro antimicrobial studies (S. aureus, P. aeruginosa, E. coli)",
    "Cell culture wound scratch assay on fibroblast cell lines",
    "In vivo wound healing studies (diabetic & non-diabetic animal models)",
    "Evaluate collagen synthesis, re-epithelialization, angiogenesis",
    "Controlled drug release profiling",
    "Advanced formulations: thermosensitive, pH-responsive, injectable, self-healing",
    "Clinical safety validation studies",
  ];
  sl.addText(futurePoints.map((p, i) => ({ text: p, options: { bullet: true, breakLine: i < futurePoints.length - 1 } })), {
    x: 6.05, y: 1.12, w: 3.45, h: 3.9,
    fontSize: 11.5, color: C.white, fontFace: "Calibri", paraSpaceAfter: 5, margin: 0
  });

  sl.addShape(pres.shapes.RECTANGLE, { x: 0, y: 5.33, w: 10, h: 0.3, fill: { color: C.mid, transparency: 80 } });
  sl.addText("Formulation and Characterization of Myristica Fragrans based Chitosan Hydrogel", { x: 0, y: 5.33, w: 10, h: 0.3, fontSize: 9, color: C.muted, fontFace: "Calibri", align: "center", valign: "middle", margin: 0 });
}

// ─────────────────────────────────────────────
// SLIDE 14 — CONCLUSION
// ─────────────────────────────────────────────
{
  const sl = pres.addSlide();
  sl.background = { color: C.dark };
  sl.addShape(pres.shapes.RECTANGLE, { x: 0, y: 0, w: 10, h: 0.07, fill: { color: C.accent } });

  // Decorative circles
  sl.addShape(pres.shapes.OVAL, { x: 7.5, y: -0.5, w: 3.5, h: 3.5, fill: { color: C.mid, transparency: 75 } });
  sl.addShape(pres.shapes.OVAL, { x: -0.5, y: 3.5, w: 2.5, h: 2.5, fill: { color: C.accent, transparency: 85 } });

  sl.addShape(pres.shapes.RECTANGLE, { x: 0.4, y: 0.22, w: 1.5, h: 0.28, fill: { color: C.accent, transparency: 30 } });
  sl.addText("CHAPTER 7", { x: 0.4, y: 0.22, w: 1.5, h: 0.28, fontSize: 9, color: C.white, fontFace: "Calibri", bold: true, align: "center", valign: "middle", margin: 0 });
  sl.addText("Conclusion", { x: 2.05, y: 0.22, w: 7.5, h: 0.28, fontSize: 22, color: C.white, fontFace: "Georgia", bold: true, margin: 0 });

  const conclusions = [
    { icon: "✓", point: "Successfully developed nutmeg-based chitosan hydrogel as a potential topical wound healing formulation" },
    { icon: "✓", point: "Desirable properties: uniform appearance, skin-compatible pH (6.5–6.7), good spreadability, appropriate gel strength" },
    { icon: "✓", point: "Pseudoplastic (shear-thinning) behavior confirmed — ideal for easy topical application and site retention" },
    { icon: "✓", point: "FTIR confirmed drug–polymer compatibility and stability; no harmful functional groups detected" },
    { icon: "✓", point: "NLHG-2.5 showed superior mechanical strength, consistency and stability across all evaluation parameters" },
    { icon: "✓", point: "NME contributes improved therapeutic potential; combination of CH + NM is promising for wound management" },
  ];

  conclusions.forEach((c, i) => {
    const y = 0.68 + i * 0.76;
    sl.addShape(pres.shapes.OVAL, { x: 0.4, y: y + 0.04, w: 0.4, h: 0.4, fill: { color: C.accent } });
    sl.addText(c.icon, { x: 0.4, y: y + 0.04, w: 0.4, h: 0.4, fontSize: 14, color: C.dark, fontFace: "Calibri", bold: true, align: "center", valign: "middle", margin: 0 });
    sl.addText(c.point, { x: 1.0, y: y + 0.06, w: 8.6, h: 0.38, fontSize: 13, color: C.light, fontFace: "Calibri", margin: 0 });
  });

  sl.addShape(pres.shapes.RECTANGLE, { x: 0.35, y: 5.12, w: 9.3, h: 0.18, fill: { color: C.accent, transparency: 60 } });
  sl.addText("Further in vitro, in vivo and clinical studies are recommended to validate safety and expand biomedical/pharmaceutical applications.", {
    x: 0.45, y: 5.12, w: 9.1, h: 0.18,
    fontSize: 10, color: C.light, fontFace: "Calibri", valign: "middle", align: "center", margin: 0
  });

  sl.addShape(pres.shapes.RECTANGLE, { x: 0, y: 5.33, w: 10, h: 0.3, fill: { color: C.mid, transparency: 60 } });
  sl.addText("Formulation and Characterization of Myristica Fragrans based Chitosan Hydrogel", { x: 0, y: 5.33, w: 10, h: 0.3, fontSize: 9, color: C.light, fontFace: "Calibri", align: "center", valign: "middle", margin: 0 });
}

// ─────────────────────────────────────────────
// SLIDE 15 — THANK YOU / Q&A
// ─────────────────────────────────────────────
{
  const sl = pres.addSlide();
  sl.background = { color: C.dark };
  sl.addShape(pres.shapes.RECTANGLE, { x: 0, y: 0, w: 10, h: 0.07, fill: { color: C.accent } });
  sl.addShape(pres.shapes.OVAL, { x: 6.5, y: 0.5, w: 4.5, h: 4.5, fill: { color: C.mid, transparency: 80 } });
  sl.addShape(pres.shapes.OVAL, { x: -1, y: 3.0, w: 3.5, h: 3.5, fill: { color: C.accent, transparency: 85 } });

  sl.addText("Thank You", {
    x: 0.5, y: 1.2, w: 9, h: 1.1,
    fontSize: 60, color: C.white, fontFace: "Georgia", bold: true, align: "center", margin: 0
  });
  sl.addText("Questions & Discussion Welcome", {
    x: 0.5, y: 2.35, w: 9, h: 0.55,
    fontSize: 22, color: C.gold, fontFace: "Georgia", italic: true, align: "center", margin: 0
  });

  sl.addShape(pres.shapes.RECTANGLE, { x: 2.5, y: 3.1, w: 5.0, h: 0.04, fill: { color: C.accent } });

  sl.addText([
    { text: "Yash Pandey", options: { bold: true, fontSize: 15 } },
    { text: "  ·  M.Sc. Biochemistry (2026)\n", options: { fontSize: 13 } },
    { text: "University of Allahabad  ·  Supervisor: Dr. Surabhi Bajpai (BHU)", options: { fontSize: 12 } },
  ], { x: 0.5, y: 3.25, w: 9, h: 0.75, color: C.light, fontFace: "Calibri", align: "center", margin: 0 });

  sl.addText('"Formulation and Characterization of Myristica Fragrans based Chitosan Hydrogel"', {
    x: 0.5, y: 4.1, w: 9, h: 0.5,
    fontSize: 13, color: C.muted, fontFace: "Georgia", italic: true, align: "center", margin: 0
  });

  sl.addShape(pres.shapes.RECTANGLE, { x: 0, y: 5.33, w: 10, h: 0.3, fill: { color: C.mid, transparency: 60 } });
  sl.addText("Thesis Defence Presentation  ·  2026", { x: 0, y: 5.33, w: 10, h: 0.3, fontSize: 10, color: C.light, fontFace: "Calibri", align: "center", valign: "middle", margin: 0 });
}

pres.writeFile({ fileName: "/home/claude/Yash_Thesis_Defence.pptx" });
console.log("Done!");