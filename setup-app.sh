#!/usr/bin/env bash
set -e

# Aseguramos estar en el directorio de la aplicación
echo "🚀 Configurando la estructura modular de test-car-app..."

# 1. Crear carpetas de assets
mkdir -p css js

# 2. Crear CSS separado
cat << 'EOF' > css/styles.css
:root {
  --bg: #0a0d14;
  --bg-card: #141923;
  --bg-card-border: #232d3f;
  --ink: #f1f5f9;
  --muted: #94a3b8;
  --line: #1e293b;
  --neon-blue: #00f3ff;
  --neon-blue-glow: rgba(0, 243, 255, 0.35);
  --neon-red: #ff2a6d;
  --neon-red-glow: rgba(255, 42, 109, 0.4);
  --neon-green: #00ff88;
  --neon-green-glow: rgba(0, 255, 136, 0.35);
  --neon-amber: #ffb703;
  --dark-red: #3f0e1d;
}

* { box-sizing: border-box; }
body {
  margin: 0;
  background: var(--bg);
  background-image: 
    radial-gradient(circle at 15% 15%, rgba(0, 243, 255, 0.05) 0%, transparent 40%),
    radial-gradient(circle at 85% 85%, rgba(255, 42, 109, 0.05) 0%, transparent 40%);
  color: var(--ink);
  font-family: 'Rajdhani', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
  font-size: 16px;
  line-height: 1.5;
  overflow-x: hidden;
}

body.glitch-intro {
  animation: glitch-anim 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94) both;
}

@keyframes glitch-anim {
  0% { transform: translate(0); filter: hue-rotate(0deg) contrast(1); }
  20% { transform: translate(-3px, 3px); filter: hue-rotate(90deg) contrast(1.5); }
  40% { transform: translate(-3px, -3px); filter: hue-rotate(180deg) contrast(2); }
  60% { transform: translate(3px, 3px); filter: hue-rotate(270deg) contrast(1.5); }
  80% { transform: translate(3px, -3px); filter: hue-rotate(360deg) contrast(1.2); }
  100% { transform: translate(0); filter: hue-rotate(0deg) contrast(1); }
}

.hazard-alert {
  animation: hazard-pulse 1s infinite alternate;
  border-bottom: 2px solid var(--neon-red) !important;
}

@keyframes hazard-pulse {
  0% { background: rgba(255, 42, 109, 0.15); box-shadow: 0 0 15px rgba(255, 42, 109, 0.4); }
  100% { background: rgba(63, 14, 29, 0.95); box-shadow: 0 0 30px rgba(255, 42, 109, 0.9); }
}

header {
  position: sticky;
  top: 0;
  z-index: 100;
  background: rgba(10, 13, 20, 0.95);
  backdrop-filter: blur(12px);
  border-bottom: 1px solid var(--neon-blue-glow);
  color: #fff;
  padding: 14px 20px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.6);
  transition: all 0.3s ease;
}

.header-content { max-width: 900px; margin: 0 auto; }
.header-top { display: flex; justify-content: space-between; align-items: center; gap: 10px; }

h1 {
  font-family: 'Orbitron', sans-serif;
  font-size: 18px;
  font-weight: 800;
  margin: 0;
  color: #fff;
  letter-spacing: 1px;
  text-shadow: 0 0 10px var(--neon-blue-glow);
}

.lang-btn {
  background: #0f131d;
  border: 1px solid var(--neon-blue);
  color: var(--neon-blue);
  padding: 4px 10px;
  border-radius: 6px;
  font-family: 'Orbitron', sans-serif;
  font-size: 11px;
  font-weight: 700;
  cursor: pointer;
  transition: all 0.2s;
}

.lang-btn:hover {
  background: var(--neon-blue);
  color: #000;
  box-shadow: 0 0 8px var(--neon-blue-glow);
}

.sub { font-size: 13px; color: var(--muted); margin-top: 2px; }

.audit-dashboard {
  display: grid;
  grid-template-columns: 1fr auto;
  gap: 15px;
  align-items: center;
  background: rgba(15, 19, 29, 0.85);
  border: 1px solid var(--line);
  padding: 12px 16px;
  border-radius: 12px;
  margin-top: 10px;
}

.score-box { text-align: right; }
.score-val {
  font-family: 'Orbitron', sans-serif;
  font-size: 32px;
  font-weight: 800;
  color: var(--neon-blue);
  text-shadow: 0 0 10px var(--neon-blue-glow);
  line-height: 1;
}

.verdict-badge {
  font-family: 'Orbitron', sans-serif;
  font-size: 11px;
  font-weight: 800;
  padding: 5px 12px;
  border-radius: 6px;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  display: inline-block;
}

.v-good { background: rgba(0, 255, 136, 0.15); color: var(--neon-green); border: 1px solid var(--neon-green); }
.v-warn { background: rgba(255, 183, 3, 0.15); color: var(--neon-amber); border: 1px solid var(--neon-amber); }
.v-bad { background: var(--dark-red); color: var(--neon-red); border: 1px solid var(--neon-red); box-shadow: 0 0 12px var(--neon-red-glow); }

main { max-width: 900px; margin: auto; padding: 20px 15px; }

.card {
  background: var(--bg-card);
  border: 1px solid var(--bg-card-border);
  border-radius: 14px;
  padding: 20px;
  margin-bottom: 20px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.4);
}

.card.danger-zone {
  border: 1px solid var(--neon-red);
  background: rgba(63, 14, 29, 0.25);
}

h2 {
  font-family: 'Orbitron', sans-serif;
  font-size: 14px;
  color: var(--neon-blue);
  margin: 0 0 14px;
  letter-spacing: 0.5px;
  text-transform: uppercase;
  border-bottom: 1px solid var(--line);
  padding-bottom: 8px;
}

.danger-zone h2 { color: var(--neon-red); border-bottom-color: rgba(255, 42, 109, 0.3); }

.grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 12px; }
.grid-3 { display: grid; grid-template-columns: repeat(3, 1fr); gap: 12px; }

.field label {
  display: block;
  font-size: 11px;
  font-weight: 700;
  color: var(--muted);
  margin-bottom: 4px;
  text-transform: uppercase;
}

input, select, textarea {
  width: 100%;
  border: 1px solid var(--line);
  border-radius: 8px;
  padding: 10px 12px;
  font: inherit;
  background: #0f131d;
  color: var(--ink);
  outline: none;
}

input:focus, select:focus, textarea:focus {
  border-color: var(--neon-blue);
  box-shadow: 0 0 10px var(--neon-blue-glow);
}

.item-audit {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 12px;
  padding: 10px 12px;
  border-radius: 8px;
  background: #0f131d;
  border: 1px solid var(--line);
  margin-bottom: 8px;
  transition: all 0.2s ease;
}

.item-audit.pass {
  border-color: rgba(0, 255, 136, 0.4);
  background: rgba(0, 255, 136, 0.03);
}

.item-audit.fail {
  border-color: var(--neon-red);
  background: rgba(255, 42, 109, 0.08);
  box-shadow: inset 0 0 10px rgba(255, 42, 109, 0.15);
}

.item-text { flex: 1; font-size: 14px; }
.item-desc { font-size: 12px; color: var(--muted); margin-top: 2px; }

.tag {
  display: inline-block;
  font-family: 'Orbitron', sans-serif;
  font-size: 9px;
  padding: 2px 5px;
  border-radius: 4px;
  font-weight: 800;
  margin-right: 6px;
}

.red { background: var(--dark-red); color: var(--neon-red); border: 1px solid var(--neon-red); }
.amber { background: rgba(255, 183, 3, 0.15); color: var(--neon-amber); border: 1px solid var(--neon-amber); }

.btn-toggle-group {
  display: flex;
  gap: 4px;
  background: var(--bg);
  padding: 3px;
  border-radius: 6px;
  border: 1px solid var(--line);
}

.btn-toggle {
  border: 0;
  background: transparent;
  color: var(--muted);
  padding: 5px 10px;
  font-family: 'Orbitron', sans-serif;
  font-size: 10px;
  font-weight: 700;
  border-radius: 4px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.btn-toggle.active-pass { background: var(--neon-green); color: #000; box-shadow: 0 0 8px var(--neon-green-glow); }
.btn-toggle.active-fail { background: var(--neon-red); color: #fff; box-shadow: 0 0 8px var(--neon-red-glow); }

.toolbar { display: flex; gap: 10px; flex-wrap: wrap; margin-top: 16px; }

button.action-btn {
  font-family: 'Orbitron', sans-serif;
  font-size: 12px;
  font-weight: 700;
  border: 0;
  border-radius: 8px;
  padding: 12px 18px;
  cursor: pointer;
  letter-spacing: 0.5px;
  transition: all 0.25s ease;
}

.primary { background: var(--neon-blue); color: #000; }
.secondary { background: rgba(0, 243, 255, 0.1); color: var(--neon-blue); border: 1px solid var(--neon-blue); }
.danger { background: rgba(255, 42, 109, 0.2); color: var(--neon-red); border: 1px solid var(--neon-red); }

.db-table-wrapper { overflow-x: auto; margin-top: 10px; }
table.db-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 13px;
  text-align: left;
}
table.db-table th, table.db-table td {
  padding: 10px;
  border-bottom: 1px solid var(--line);
}
table.db-table th {
  color: var(--neon-blue);
  font-family: 'Orbitron', sans-serif;
  font-size: 11px;
}
table.db-table tr:hover { background: rgba(255,255,255,0.02); }

.action-sm-btn {
  padding: 4px 8px;
  font-size: 10px;
  border-radius: 4px;
  border: none;
  cursor: pointer;
  font-family: 'Orbitron', sans-serif;
  margin-right: 4px;
}
.btn-load { background: var(--neon-blue); color: #000; }
.btn-del { background: var(--neon-red); color: #fff; }

@media(max-width: 768px) {
  .grid, .grid-3 { grid-template-columns: 1fr; }
  .item-audit { flex-direction: column; align-items: flex-start; }
  .btn-toggle-group { width: 100%; justify-content: space-between; }
  .btn-toggle { flex: 1; text-align: center; }
  .audit-dashboard { grid-template-columns: 1fr; text-align: center; }
  .score-box { text-align: center; margin-top: 10px; }
}
EOF

# 3. Crear JS separado
cat << 'EOF' > js/app.js
let audioCtx = null;

function getAudioContext() {
  if (!audioCtx) {
    audioCtx = new (window.AudioContext || window.webkitAudioContext)();
  }
  if (audioCtx.state === 'suspended') {
    audioCtx.resume();
  }
  return audioCtx;
}

function playIntroGlitchSound() {
  try {
    const ctx = getAudioContext();
    const now = ctx.currentTime;
    const bufferSize = ctx.sampleRate * 0.15;
    const buffer = ctx.createBuffer(1, bufferSize, ctx.sampleRate);
    const data = buffer.getChannelData(0);
    for (let i = 0; i < bufferSize; i++) {
      data[i] = Math.random() * 2 - 1;
    }

    const noise = ctx.createBufferSource();
    noise.buffer = buffer;

    const filter = ctx.createBiquadFilter();
    filter.type = 'bandpass';
    filter.frequency.setValueAtTime(800, now);
    filter.frequency.exponentialRampToValueAtTime(3000, now + 0.12);

    const gain = ctx.createGain();
    gain.gain.setValueAtTime(0.08, now);
    gain.gain.exponentialRampToValueAtTime(0.001, now + 0.15);

    noise.connect(filter);
    filter.connect(gain);
    gain.connect(ctx.destination);

    noise.start(now);
  } catch (e) { console.log('Audio init pending user interaction'); }
}

function playCriticalFailSound() {
  try {
    const ctx = getAudioContext();
    const now = ctx.currentTime;
    const osc = ctx.createOscillator();
    const gain = ctx.createGain();

    osc.type = 'sawtooth';
    osc.frequency.setValueAtTime(150, now);
    osc.frequency.setValueAtTime(80, now + 0.05);
    osc.frequency.setValueAtTime(220, now + 0.09);
    osc.frequency.setValueAtTime(60, now + 0.14);

    gain.gain.setValueAtTime(0.12, now);
    gain.gain.exponentialRampToValueAtTime(0.001, now + 0.2);

    osc.connect(gain);
    gain.connect(ctx.destination);

    osc.start(now);
    osc.stop(now + 0.2);
  } catch (e) { }
}

function playHazardAlertSound() {
  try {
    const ctx = getAudioContext();
    const now = ctx.currentTime;
    const osc1 = ctx.createOscillator();
    const gain = ctx.createGain();

    osc1.type = 'triangle';
    osc1.frequency.setValueAtTime(180, now);
    osc1.frequency.linearRampToValueAtTime(120, now + 0.3);
    osc1.frequency.linearRampToValueAtTime(180, now + 0.6);

    gain.gain.setValueAtTime(0.1, now);
    gain.gain.linearRampToValueAtTime(0.02, now + 0.3);
    gain.gain.linearRampToValueAtTime(0.1, now + 0.6);
    gain.gain.exponentialRampToValueAtTime(0.001, now + 0.8);

    osc1.connect(gain);
    gain.connect(ctx.destination);

    osc1.start(now);
    osc1.stop(now + 0.8);
  } catch (e) { }
}

const topBrandsSpain = {
  "Seat": ["Ibiza", "Leon", "Arona", "Ateca", "Tarraco"],
  "Toyota": ["Yaris", "Yaris Cross", "Corolla", "C-HR", "RAV4"],
  "Peugeot": ["208", "2008", "308", "3008", "5008"],
  "Volkswagen": ["Polo", "Golf", "T-Roc", "T-Cross", "Tiguan"],
  "Renault": ["Clio", "Captur", "Megane", "Arkana", "Austral"],
  "Kia": ["Picanto", "Stonic", "Ceed", "Niro", "Sportage"],
  "Hyundai": ["i20", "i30", "Kona", "Tucson", "Santa Fe"],
  "Dacia": ["Sandero", "Duster", "Jogger", "Spring"],
  "Citroën": ["C3", "C3 Aircross", "C4", "C5 Aircross"],
  "Ford": ["Fiesta", "Puma", "Focus", "Kuga"]
};

let currentLang = 'es';

const translations = {
  es: {
    title: "🛡 AUDITORÍA INTEGRAL DE VEHÍCULO USADO",
    sub: "Verificación DGT, prueba de verificación de inundación, transmisión y base de datos local SQLite/IndexedDB.",
    confidence: "ÍNDICE DE CONFIANZA",
    sec1: "1 · Selección de Vehículo Usado y Datos Iniciales",
    lblBrand: "Marca (Top 10 España)",
    lblModel: "Modelo",
    lblFuel: "Motor / Propulsión",
    lblVersion: "Versión / Trim / Acabado",
    lblYear: "Año de Matriculación",
    lblPrice: "Precio Venta (€)",
    lblKm: "Kilometraje Declarado",
    lblVin: "Matrícula / VIN",
    lblRepairs: "Presupuesto Reparaciones Estimado (€)",
    btnSave: "💾 GUARDAR EN BASE DE DATOS",
    btnNew: "➕ NUEVA EVALUACIÓN",
    secDb: "2 · Registro de Vehículos Guardados (Base de Datos Local)",
    thCar: "Vehículo",
    thEngine: "Motor / Año",
    thPrice: "Precio",
    thScore: "Puntuación",
    thActions: "Acciones",
    noCars: "No hay vehículos guardados en la base de datos.",
    secIdent: "3 · Identificación y Kilometraje (Cruce de Fuentes)",
    secDocs: "4 · Documentación y Situación Legal",
    secFlood: "5 · Carrocería, Golpes, Corrosión y Verificación de Inundación",
    secEngine: "6 · Motor y Sistema de Propulsión",
    secTrans: "7 · Cambio, Embrague y Transmisión",
    secChassis: "8 · Suspensión, Dirección, Frenos y Neumáticos",
    secElec: "9 · Electricidad, Seguridad y Climatización",
    secWorkshop: "10 · Elevador + Diagnosis Independiente en Taller",
    secDrive: "11 · Prueba de Conducción Dinámica",
    secStop: "12 · Banderas Rojas y Señales para Detener la Compra",
    secNotes: "Notas Finales y Estrategia de Negociación",
    btnPdf: "🖨️ EXPORTAR INFORME PDF",
    btnReset: "🗑️ REINICIAR PRUEBAS ACTUALES",
    btnLang: "🇬🇧 English",
    vGood: "✅ VEHÍCULO APTO Y COMPROBADO",
    vWarn: "⚠️ PRECAUCIÓN / DESCONTAR REPARACIONES",
    vBad: "⛔ CANCELAR COMPRA (RIESGO CRÍTICO)",
    vZero: "🚨 ALERTA MÁXIMA: RIESGO EXTREMO (0%)",
    vUnchecked: "SIN EVALUAR"
  },
  en: {
    title: "🛡 INTEGRAL USED CAR AUDIT & INSPECTION",
    sub: "DGT verification, flood verification test, transmission test, and local SQLite/IndexedDB database.",
    confidence: "CONFIDENCE INDEX",
    sec1: "1 · Used Vehicle Selection & Initial Data",
    lblBrand: "Brand (Top 10 Spain)",
    lblModel: "Model",
    lblFuel: "Engine / Drivetrain",
    lblVersion: "Version / Trim Level",
    lblYear: "Registration Year",
    lblPrice: "Asking Price (€)",
    lblKm: "Odometer Reading (KM)",
    lblVin: "Plate / VIN Number",
    lblRepairs: "Estimated Repair Budget (€)",
    btnSave: "💾 SAVE TO DATABASE",
    btnNew: "➕ NEW EVALUATION",
    secDb: "2 · Saved Vehicle Records (Local Database)",
    thCar: "Vehicle",
    thEngine: "Engine / Year",
    thPrice: "Price",
    thScore: "Score",
    thActions: "Actions",
    noCars: "No vehicles saved in the local database.",
    secIdent: "3 · Identification & Mileage Check",
    secDocs: "4 · Documentation & Legal Status",
    secFlood: "5 · Bodywork, Crashes, Corrosion & Flood Verification Test",
    secEngine: "6 · Engine & Powertrain System",
    secTrans: "7 · Gearbox, Clutch & Drivetrain",
    secChassis: "8 · Suspension, Steering, Brakes & Tyres",
    secElec: "9 · Electrical Systems, Safety & AC",
    secWorkshop: "10 · Hydraulic Lift & Independent Workshop Diagnostic",
    secDrive: "11 · Dynamic Road Drive Test",
    secStop: "12 · Red Flags & STOP PURCHASE Signals",
    secNotes: "Final Notes & Negotiation Strategy",
    btnPdf: "🖨️ EXPORT PDF REPORT",
    btnReset: "🗑️ RESET CURRENT TESTS",
    btnLang: "🇪🇸 Español",
    vGood: "✅ VEHICLE APPROVED & VERIFIED",
    vWarn: "⚠️ CAUTION / DEDUCT REPAIR COSTS",
    vBad: "⛔ CANCEL PURCHASE (CRITICAL RISK)",
    vZero: "🚨 HAZARD: EXTREME RISK (0%)",
    vUnchecked: "UNCHECKED"
  }
};

const auditItems = [
  { id: 'km_req_vin', sec: 1, text: 'Pedir matrícula y VIN antes de desplazarte a la inspección', desc: 'Permite hacer comprobaciones preventivas antes de la visita.', critical: true, penalty: 20 },
  { id: 'km_dgt_full', sec: 1, text: 'Informe DGT completo: comprobados titulares, ITV, kilometrajes y cargas', critical: true, penalty: 35 },
  { id: 'km_itv_progression', sec: 1, text: 'Comparar lecturas de KM en ITV y comprobar progresión cronológica lógica', critical: true, penalty: 35 },
  { id: 'km_invoices_chronology', sec: 1, text: 'Ordenar facturas por fecha y verificar incremento lógico de kilometraje', critical: false, penalty: 15 },
  { id: 'km_workshop_contact', sec: 1, text: 'Contactar con talleres de facturas para confirmar fecha, km y trabajos', critical: false, penalty: 15 },
  { id: 'km_official_history', sec: 1, text: 'Historial de mantenimiento oficial del fabricante verificado', critical: false, penalty: 15 },
  { id: 'km_obd_diag_modules', sec: 1, text: 'Diagnosis electrónica completa en búsqueda de incoherencias entre módulos', critical: false, penalty: 20 },
  { id: 'km_wear_physical', sec: 1, text: 'Desgaste de volante, pomo, pedales, asiento, cinturón, botones y alfombrillas coherente', critical: false, penalty: 15 },
  { id: 'km_cluster_tampering', sec: 1, text: 'Cuadro de instrumentos sin indicios de desmontaje o sustitución', critical: true, penalty: 25 },
  { id: 'km_not_validated_flag', sec: 1, text: 'Kilometraje razonablemente documentado y validado', desc: 'Si no se documenta, indicar que el kilometraje declarado NO está validado.', critical: true, penalty: 30 },
  { id: 'doc_orig_permiso_ficha', sec: 2, text: 'Permiso de circulación y ficha técnica originales comprobados', critical: true, penalty: 30 },
  { id: 'doc_vin_match_3way', sec: 2, text: 'VIN del vehículo = VIN de documentación = VIN del informe DGT', critical: true, penalty: 40 },
  { id: 'doc_seller_owner_match', sec: 2, text: 'El vendedor coincide con el titular o acredita poder legal formal de venta', critical: true, penalty: 30 },
  { id: 'doc_dgt_no_loads', sec: 2, text: 'Informe DGT libre de cargas, embargos, precintos o reservas de dominio', critical: true, penalty: 40 },
  { id: 'doc_itv_valid_no_defects', sec: 2, text: 'ITV vigente y sin defectos pendientes de resolución', critical: false, penalty: 15 },
  { id: 'doc_recalls_checked', sec: 2, text: 'Sin campañas o llamadas a revisión pendientes según consulta del fabricante', critical: false, penalty: 10 },
  { id: 'doc_contract_ready', sec: 2, text: 'Borrador de contrato preparado con matrícula, VIN, precio, fecha y km declarados', critical: false, penalty: 10 },
  { id: 'body_natural_light', sec: 3, text: 'Inspección realizada con luz natural y carrocería completamente limpia', critical: false, penalty: 10 },
  { id: 'body_paint_texture', sec: 3, text: 'Comparación de color y textura entre paneles (sin sombras ni tono desigual)', critical: false, penalty: 15 },
  { id: 'body_panel_gaps', sec: 3, text: 'Holguras y alineación simétrica en puertas, capó, portón y aletas', critical: false, penalty: 15 },
  { id: 'body_overspray_welds', sec: 3, text: 'Sin overspray de pintura, tornillos marcados, soldaduras o plegados anómalos', critical: true, penalty: 25 },
  { id: 'body_chassis_corrosion', sec: 3, text: 'Bajos, pasos de rueda, subchasis, largueros y puntos de elevación sin golpes ni corrosión', critical: true, penalty: 35 },
  { id: 'body_glass_dates', sec: 3, text: 'Comprobación de fechas/códigos en lunas y registro de sustituciones', critical: false, penalty: 10 },
  { id: 'body_towbar_racks', sec: 3, text: 'Bola/portabicis/barras: anclajes, documentación y ausencias de sobrecarga', critical: false, penalty: 10 },
  { id: 'body_flood_verification', sec: 3, text: 'Prueba de Verificación de Inundación: Interior y chasis libres de lodo, arena fina o moho', desc: 'Revisar raíles de asientos, hueco de rueda de repuesto y caja de fusibles.', critical: true, penalty: 40 },
  { id: 'eng_cold_start_check', sec: 4, text: 'EN FRÍO: Se ha verificado que el motor estaba totalmente frío antes del arranque', critical: true, penalty: 30 },
  { id: 'eng_smooth_idle', sec: 4, text: 'Arranque fácil y régimen de ralentí totalmente estable', critical: false, penalty: 15 },
  { id: 'eng_exhaust_smoke', sec: 4, text: 'Sin humo anómalo por el escape al arrancar y acelerar (azul, negro o blanco espeso)', critical: true, penalty: 25 },
  { id: 'eng_noises_check', sec: 4, text: 'Ausencia de ruidos anómalos de distribución, accesorios, turbo, inyección o A/A', critical: true, penalty: 30 },
  { id: 'eng_leaks_check', sec: 4, text: 'Ausencia de fugas de aceite, refrigerante, combustible o AdBlue', critical: true, penalty: 25 },
  { id: 'eng_temp_fans', sec: 4, text: 'Temperatura de funcionamiento estable y correcto encendido de ventiladores', critical: false, penalty: 15 },
  { id: 'eng_oil_consumption', sec: 4, text: 'Preguntado consumo de aceite y revisada la documentación de cambios', critical: false, penalty: 10 },
  { id: 'eng_obd_mfg_diag', sec: 4, text: 'Comprobación de testigos e inspección mediante diagnosis OBD2', critical: true, penalty: 25 },
  { id: 'trans_manual_clutch', sec: 5, text: 'Caja manual: embrague sin patinamiento, punto de fricción razonable y sin ruidos', critical: false, penalty: 20 },
  { id: 'trans_auto_test', sec: 5, text: 'Caja Automática/DCT/CVT: prueba en frío/caliente, cambios suaves sin patinar ni tirones', critical: true, penalty: 35 },
  { id: 'trans_atf_invoices', sec: 5, text: 'Facturas de mantenimiento de aceite/ATF/fluido de transmisión verificadas', critical: false, penalty: 15 },
  { id: 'trans_leaks', sec: 5, text: 'Revisión técnica de posibles fugas de fluido en la transmisión', critical: false, penalty: 15 },
  { id: 'trans_4x4_awd', sec: 6, text: '4x4/AWD: árbol, diferenciales, palieres, fuelles y mantenimiento específico ok', critical: false, penalty: 20 },
  { id: 'chass_tyres_dot', sec: 6, text: 'Neumáticos: medida correcta, desgaste uniforme y fecha DOT limpia (<5 años)', critical: false, penalty: 15 },
  { id: 'chass_no_vibration', sec: 6, text: 'Dirección y volante completamente libres de vibraciones a velocidad de carretera', critical: false, penalty: 15 },
  { id: 'chass_no_clonk', sec: 6, text: 'Ausencia de golpes o ruidos "clonk" al pasar por baches e irregularidades', critical: false, penalty: 15 },
  { id: 'chass_shocks', sec: 6, text: 'Amortiguadores sin fugas de aceite y con respuesta de rebote uniforme', critical: false, penalty: 15 },
  { id: 'chass_lift_inspection', sec: 6, text: 'En elevador: rótulas, bieletas, silentblocks, rodamientos, palieres y fuelles ok', critical: false, penalty: 15 },
  { id: 'chass_firm_braking', sec: 6, text: 'Frenada progresiva y firme sin vibraciones ni desviación del volante', critical: true, penalty: 25 },
  { id: 'chass_discs_pads', sec: 6, text: 'Valoración del desgaste de discos/pastillas y fecha de última sustitución', critical: false, penalty: 10 },
  { id: 'elec_warning_lights', sec: 7, text: 'Todos los testigos se encienden al dar contacto y se apagan al arrancar', critical: true, penalty: 30 },
  { id: 'elec_safety_systems', sec: 7, text: 'Sistemas ABS/ESP/VSA/Airbag sin testigos encendidos o errores guardados', critical: true, penalty: 30 },
  { id: 'elec_ac_heating', sec: 7, text: 'Funcionamiento correcto de aire acondicionado y calefacción', critical: false, penalty: 15 },
  { id: 'elec_aux_systems', sec: 7, text: 'Luces, elevalunas, cierre, espejos, limpiaparabrisas y luneta térmica ok', critical: false, penalty: 10 },
  { id: 'elec_battery_alt', sec: 7, text: 'Medición de voltaje de batería y carga de alternador en rango correcto', critical: false, penalty: 10 },
  { id: 'elec_moisture_leaks', sec: 7, text: 'Ausencia de humedad o filtraciones en moquetas, maletero y rueda de repuesto', critical: true, penalty: 25 },
  { id: 'shop_independent_choice', sec: 8, text: 'Taller independiente elegido por el COMPRADOR (no sugerido por el vendedor)', critical: true, penalty: 30 },
  { id: 'shop_full_obd_diag', sec: 8, text: 'Diagnosis completa de módulos y lectura de errores presentes e históricos', critical: true, penalty: 25 },
  { id: 'shop_underbody_structural', sec: 8, text: 'Inspección de fugas, bajos, subchasis y posibles reparaciones estructurales', critical: true, penalty: 35 },
  { id: 'shop_full_mech_review', sec: 8, text: 'Revisión técnica de motor, transmisión, suspensión, dirección, frenos y escape', critical: false, penalty: 20 },
  { id: 'shop_ev_hv_battery_soh', sec: 8, text: 'Híbridos/EV: Diagnóstico de batería de tracción, SOH, refrigeración y alta tensión', critical: true, penalty: 35 },
  { id: 'shop_written_quote', sec: 8, text: 'Presupuesto por escrito obtenido del taller para descontar de la oferta', critical: false, penalty: 15 },
  { id: 'drive_cold_start', sec: 9, text: 'Prueba iniciada con el motor totalmente en frío', critical: true, penalty: 25 },
  { id: 'drive_city_test', sec: 9, text: 'Prueba urbana: dirección, embrague/cambio, frenos, suspensión y temperatura', critical: false, penalty: 15 },
  { id: 'drive_road_test', sec: 9, text: 'Prueba en carretera: estabilidad, vibraciones, ruidos y comportamiento', critical: false, penalty: 15 },
  { id: 'drive_acceleration', sec: 9, text: 'Aceleración progresiva y fuerte probada en lugar seguro', critical: false, penalty: 15 },
  { id: 'drive_firm_stop', sec: 9, text: 'Frenada de emergencia controlada y firme en lugar seguro', critical: true, penalty: 20 },
  { id: 'drive_post_check', sec: 9, text: 'Comprobación posterior tras conducir: fugas, olores, temperatura y ventiladores', critical: false, penalty: 15 },
  { id: 'stop_no_vin_docs', sec: 10, text: '🚨 PARAR: No facilita matrícula, VIN o documentación básica original', critical: true, penalty: 40 },
  { id: 'stop_km_fraud', sec: 10, text: '🚨 PARAR: Incoherencias de kilometraje sin explicación documental convincente', critical: true, penalty: 40 },
  { id: 'stop_vin_mismatch', sec: 10, text: '🚨 PARAR: VIN troquelado en el coche y documentos NO coinciden', critical: true, penalty: 40 },
  { id: 'stop_refuse_inspection', sec: 10, text: '🚨 PARAR: Se niega rotundamente a una inspección independiente o prueba en frío', critical: true, penalty: 40 },
  { id: 'stop_severe_damage', sec: 10, text: '🚨 PARAR: Problemas graves de transmisión, estructura o seguridad', critical: true, penalty: 40 },
  { id: 'stop_recalculate_costs', sec: 10, text: 'RECALCULAR: Varias reparaciones pendientes convertidas a € para descontar del precio final', critical: false, penalty: 10 }
];

let auditState = {};
let currentCarId = null;
let db = null;

function initDatabase() {
  const request = indexedDB.open("UsedCarAuditDB_v2", 1);
  request.onupgradeneeded = function(e) {
    db = e.target.result;
    if (!db.objectStoreNames.contains("cars")) {
      db.createObjectStore("cars", { keyPath: "id", autoIncrement: true });
    }
  };
  request.onsuccess = function(e) {
    db = e.target.result;
    loadCarsFromDB();
  };
  request.onerror = function(e) {
    console.error("Error al abrir la base de datos IndexedDB", e);
  };
}

function initApp() {
  populateBrands();
  auditItems.forEach(item => { auditState[item.id] = 0; });
  renderItems();
  evaluateRisk();
  initDatabase();

  const triggerAudioOnFirstTouch = () => {
    playIntroGlitchSound();
    window.removeEventListener('click', triggerAudioOnFirstTouch);
    window.removeEventListener('touchstart', triggerAudioOnFirstTouch);
  };
  window.addEventListener('click', triggerAudioOnFirstTouch);
  window.addEventListener('touchstart', triggerAudioOnFirstTouch);
}

function populateBrands() {
  const brandSelect = document.getElementById('car_brand');
  brandSelect.innerHTML = '<option value="">-- Seleccionar Marca --</option>';
  Object.keys(topBrandsSpain).sort().forEach(brand => {
    const opt = document.createElement('option');
    opt.value = brand;
    opt.textContent = brand;
    brandSelect.appendChild(opt);
  });
}

function onBrandChange() {
  const brand = document.getElementById('car_brand').value;
  const modelSelect = document.getElementById('car_model');
  modelSelect.innerHTML = '<option value="">-- Seleccionar Modelo --</option>';

  if (brand && topBrandsSpain[brand]) {
    topBrandsSpain[brand].forEach(model => {
      const opt = document.createElement('option');
      opt.value = model;
      opt.textContent = model;
      modelSelect.appendChild(opt);
    });
  }
}

function renderItems() {
  const containers = {};
  for (let i = 1; i <= 10; i++) {
    const c = document.getElementById('section-' + i);
    if (c) { c.innerHTML = ''; containers[i] = c; }
  }

  auditItems.forEach(item => {
    const container = containers[item.sec];
    if(!container) return;

    const div = document.createElement('div');
    div.className = `item-audit ${auditState[item.id] === 1 ? 'pass' : auditState[item.id] === -1 ? 'fail' : ''}`;
    div.id = 'row_' + item.id;

    div.innerHTML = `
      <div class="item-text">
        <div>
          ${item.critical ? '<span class="tag red">CRÍTICO (-' + item.penalty + ' pts)</span>' : '<span class="tag amber">GRAVE (-' + item.penalty + ' pts)</span>'}
          <b>${item.text}</b>
        </div>
        ${item.desc ? `<div class="item-desc">${item.desc}</div>` : ''}
      </div>
      <div class="btn-toggle-group">
        <button class="btn-toggle ${auditState[item.id] === 1 ? 'active-pass' : ''}" onclick="setStatus('${item.id}', 1)">OK</button>
        <button class="btn-toggle ${auditState[item.id] === -1 ? 'active-fail' : ''}" onclick="setStatus('${item.id}', -1)">FALLO</button>
      </div>
    `;
    container.appendChild(div);
  });
}

function setStatus(id, val) {
  auditState[id] = auditState[id] === val ? 0 : val;
  const itemObj = auditItems.find(it => it.id === id);

  if (auditState[id] === -1 && itemObj && itemObj.critical) {
    playCriticalFailSound();
  }

  const row = document.getElementById('row_' + id);
  row.className = `item-audit ${auditState[id] === 1 ? 'pass' : auditState[id] === -1 ? 'fail' : ''}`;
  const btns = row.querySelectorAll('.btn-toggle');
  btns[0].className = `btn-toggle ${auditState[id] === 1 ? 'active-pass' : ''}`;
  btns[1].className = `btn-toggle ${auditState[id] === -1 ? 'active-fail' : ''}`;
  evaluateRisk();
}

function calculateScore() {
  let score = 100;
  let totalChecked = 0;
  let totalFails = 0;
  let criticalFails = 0;

  auditItems.forEach(item => {
    const st = auditState[item.id];
    if (st !== 0) totalChecked++;
    if (st === -1) {
      totalFails++;
      score -= item.penalty;
      if (item.critical) criticalFails++;
    }
  });

  return { score: Math.max(0, score), totalChecked, totalFails, criticalFails };
}

function evaluateRisk() {
  const { score, totalChecked, totalFails, criticalFails } = calculateScore();
  const t = translations[currentLang];

  const scoreEl = document.getElementById('score-display');
  const badgeEl = document.getElementById('verdict-badge');
  const statsEl = document.getElementById('stats-detail');
  const headerEl = document.getElementById('main-header');

  scoreEl.textContent = score;
  statsEl.textContent = `${totalChecked}/${auditItems.length} Checkpoints · ${totalFails} Fallos`;

  if (score === 0 && totalChecked > 0) {
    badgeEl.textContent = t.vZero;
    badgeEl.className = 'verdict-badge v-bad';
    scoreEl.style.color = 'var(--neon-red)';
    headerEl.classList.add('hazard-alert');
    playHazardAlertSound();
  } else if (criticalFails > 0 || score < 50) {
    headerEl.classList.remove('hazard-alert');
    badgeEl.textContent = t.vBad;
    badgeEl.className = 'verdict-badge v-bad';
    scoreEl.style.color = 'var(--neon-red)';
  } else if (score < 85 || totalFails > 0) {
    headerEl.classList.remove('hazard-alert');
    badgeEl.textContent = t.vWarn;
    badgeEl.className = 'verdict-badge v-warn';
    scoreEl.style.color = 'var(--neon-amber)';
  } else if (totalChecked === 0) {
    headerEl.classList.remove('hazard-alert');
    badgeEl.textContent = t.vUnchecked;
    badgeEl.className = 'verdict-badge v-good';
    scoreEl.style.color = 'var(--neon-blue)';
  } else {
    headerEl.classList.remove('hazard-alert');
    badgeEl.textContent = t.vGood;
    badgeEl.className = 'verdict-badge v-good';
    scoreEl.style.color = 'var(--neon-green)';
  }
}

function saveCarToDB() {
  if (!db) return;
  const brand = document.getElementById('car_brand').value;
  const model = document.getElementById('car_model').value;
  if (!brand || !model) {
    alert(currentLang === 'es' ? "Por favor selecciona al menos Marca y Modelo." : "Please select at least Brand and Model.");
    return;
  }

  const { score } = calculateScore();
  const carData = {
    brand: brand,
    model: model,
    fuel: document.getElementById('car_fuel').value,
    version: document.getElementById('car_version').value,
    year: document.getElementById('car_year').value,
    price: document.getElementById('price').value,
    km: document.getElementById('km').value,
    vin: document.getElementById('vin_plate').value,
    repairCost: document.getElementById('repair_cost').value,
    notes: document.getElementById('notes').value,
    auditState: auditState,
    score: score,
    updatedAt: new Date().toISOString()
  };

  const tx = db.transaction(["cars"], "readwrite");
  const store = tx.objectStore("cars");

  if (currentCarId !== null) {
    carData.id = currentCarId;
    store.put(carData);
  } else {
    store.add(carData);
  }

  tx.oncomplete = function() {
    alert(currentLang === 'es' ? "¡Vehículo guardado con éxito en la base de datos!" : "Vehicle saved successfully to database!");
    loadCarsFromDB();
  };
}

function loadCarsFromDB() {
  if (!db) return;
  const tx = db.transaction(["cars"], "readonly");
  const store = tx.objectStore("cars");
  const req = store.getAll();

  req.onsuccess = function() {
    const cars = req.result;
    const tbody = document.getElementById('db-cars-list');
    tbody.innerHTML = '';

    if (cars.length === 0) {
      tbody.innerHTML = `<tr><td colspan="6" style="text-align: center; color: var(--muted);">${translations[currentLang].noCars}</td></tr>`;
      return;
    }

    cars.forEach(car => {
      const tr = document.createElement('tr');
      tr.innerHTML = `
        <td>#${car.id}</td>
        <td><b>${car.brand} ${car.model}</b> <br><small style="color: var(--muted);">${car.version || '-'}</small></td>
        <td>${car.fuel} (${car.year || 'N/A'})</td>
        <td>${car.price ? car.price + ' €' : '-'}</td>
        <td><b style="color: var(--neon-blue);">${car.score}/100</b></td>
        <td>
          <button class="action-sm-btn btn-load" onclick="editCar(${car.id})">✏️ Editar</button>
          <button class="action-sm-btn btn-del" onclick="deleteCar(${car.id})">🗑️ Borrar</button>
        </td>
      `;
      tbody.appendChild(tr);
    });
  };
}

function editCar(id) {
  const tx = db.transaction(["cars"], "readonly");
  const store = tx.objectStore("cars");
  const req = store.get(id);

  req.onsuccess = function() {
    const car = req.result;
    if (!car) return;

    currentCarId = car.id;
    document.getElementById('car_brand').value = car.brand;
    onBrandChange();
    document.getElementById('car_model').value = car.model;
    document.getElementById('car_fuel').value = car.fuel;
    document.getElementById('car_version').value = car.version || '';
    document.getElementById('car_year').value = car.year || '';
    document.getElementById('price').value = car.price || '';
    document.getElementById('km').value = car.km || '';
    document.getElementById('vin_plate').value = car.vin || '';
    document.getElementById('repair_cost').value = car.repairCost || '';
    document.getElementById('notes').value = car.notes || '';

    auditState = car.auditState || {};
    renderItems();
    evaluateRisk();

    window.scrollTo({ top: 0, behavior: 'smooth' });
  };
}

function deleteCar(id) {
  if (!confirm(currentLang === 'es' ? "¿Deseas eliminar este registro de la base de datos?" : "Do you want to delete this record from the database?")) return;
  const tx = db.transaction(["cars"], "readwrite");
  const store = tx.objectStore("cars");
  store.delete(id);
  tx.oncomplete = function() {
    if (currentCarId === id) clearForm();
    loadCarsFromDB();
  };
}

function clearForm() {
  currentCarId = null;
  document.getElementById('car_brand').value = '';
  document.getElementById('car_model').innerHTML = '<option value="">-- Seleccionar Modelo --</option>';
  document.getElementById('car_version').value = '';
  document.getElementById('car_year').value = '';
  document.getElementById('price').value = '';
  document.getElementById('km').value = '';
  document.getElementById('vin_plate').value = '';
  document.getElementById('repair_cost').value = '';
  document.getElementById('notes').value = '';

  auditItems.forEach(item => { auditState[item.id] = 0; });
  renderItems();
  evaluateRisk();
}

function resetAudit() {
  if(!confirm(currentLang === 'es' ? "¿Reiniciar todas las pruebas del formulario actual?" : "Reset all checks in current form?")) return;
  auditItems.forEach(item => { auditState[item.id] = 0; });
  renderItems();
  evaluateRisk();
}

function toggleLanguage() {
  currentLang = currentLang === 'es' ? 'en' : 'es';
  const t = translations[currentLang];

  document.getElementById('app-title').textContent = t.title;
  document.getElementById('app-sub').textContent = t.sub;
  document.getElementById('lbl-confidence').textContent = t.confidence;
  document.getElementById('sec-car-selection').textContent = t.sec1;
  document.getElementById('lbl-brand').textContent = t.lblBrand;
  document.getElementById('lbl-model').textContent = t.lblModel;
  document.getElementById('lbl-fuel').textContent = t.lblFuel;
  document.getElementById('lbl-version').textContent = t.lblVersion;
  document.getElementById('lbl-year').textContent = t.lblYear;
  document.getElementById('lbl-price').textContent = t.lblPrice;
  document.getElementById('lbl-km').textContent = t.lblKm;
  document.getElementById('lbl-vin').textContent = t.lblVin;
  document.getElementById('lbl-repairs').textContent = t.lblRepairs;
  document.getElementById('btn-save-db').textContent = t.btnSave;
  document.getElementById('btn-new-car').textContent = t.btnNew;
  document.getElementById('sec-db-list').textContent = t.secDb;
  document.getElementById('th-car').textContent = t.thCar;
  document.getElementById('th-engine').textContent = t.thEngine;
  document.getElementById('th-price').textContent = t.thPrice;
  document.getElementById('th-score').textContent = t.thScore;
  document.getElementById('th-actions').textContent = t.thActions;
  document.getElementById('sec-ident').textContent = t.secIdent;
  document.getElementById('sec-docs').textContent = t.secDocs;
  document.getElementById('sec-flood').textContent = t.secFlood;
  document.getElementById('sec-engine').textContent = t.secEngine;
  document.getElementById('sec-trans').textContent = t.secTrans;
  document.getElementById('sec-chassis').textContent = t.secChassis;
  document.getElementById('sec-elec').textContent = t.secElec;
  document.getElementById('sec-workshop').textContent = t.secWorkshop;
  document.getElementById('sec-drive').textContent = t.secDrive;
  document.getElementById('sec-stop').textContent = t.secStop;
  document.getElementById('sec-notes').textContent = t.secNotes;
  document.getElementById('btn-pdf').textContent = t.btnPdf;
  document.getElementById('btn-reset').textContent = t.btnReset;
  document.getElementById('lang-toggle-btn').textContent = t.btnLang;

  evaluateRisk();
  loadCarsFromDB();
}

initApp();
EOF

# 4. Generar index.html modularizado
cat << 'EOF' > index.html
<!doctype html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
  <meta name="theme-color" content="#0a0d14">
  <title>Auditoría Integral y Diagnóstico de Vehículo Usado</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@600;800&family=Rajdhani:wght@500;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="css/styles.css">
</head>
<body class="glitch-intro">

<header id="main-header">
  <div class="header-content">
    <div class="header-top">
      <h1 id="app-title">🛡 AUDITORÍA INTEGRAL DE VEHÍCULO USADO</h1>
      <button class="lang-btn" onclick="toggleLanguage()" id="lang-toggle-btn">🇬🇧 English</button>
    </div>
    <div class="sub" id="app-sub">Verificación DGT, prueba de verificación de inundación, transmisión y base de datos local SQLite/IndexedDB.</div>

    <div class="audit-dashboard">
      <div>
        <span id="verdict-badge" class="verdict-badge v-good">SIN EVALUAR</span>
        <div style="font-size: 12px; color: var(--muted); margin-top: 4px;" id="stats-detail">0 Comprobados · 0 Fallos</div>
      </div>
      <div class="score-box">
        <div class="score-val" id="score-display">100</div>
        <div style="font-size: 10px; color: var(--muted); font-family: 'Orbitron';" id="lbl-confidence">ÍNDICE DE CONFIANZA</div>
      </div>
    </div>
  </div>
</header>

<main>
  <section class="card">
    <h2 id="sec-car-selection">1 · Selección de Vehículo Usado y Datos Iniciales</h2>
    <div class="grid-3">
      <div class="field">
        <label id="lbl-brand">Marca (Top 10 España)</label>
        <select id="car_brand" onchange="onBrandChange()">
          <option value="">-- Seleccionar Marca --</option>
        </select>
      </div>
      <div class="field">
        <label id="lbl-model">Modelo</label>
        <select id="car_model">
          <option value="">-- Seleccionar Modelo --</option>
        </select>
      </div>
      <div class="field">
        <label id="lbl-fuel">Motor / Propulsión</label>
        <select id="car_fuel">
          <option value="Gasolina">Gasolina</option>
          <option value="Diésel">Diésel</option>
          <option value="Híbrido (HEV)">Híbrido (HEV)</option>
          <option value="Híbrido Enchufable (PHEV)">Híbrido Enchufable (PHEV)</option>
          <option value="Eléctrico (EV)">Eléctrico (EV)</option>
          <option value="GLP / GNC">GLP / GNC</option>
        </select>
      </div>
    </div>

    <div class="grid" style="margin-top: 12px;">
      <div class="field"><label id="lbl-version">Versión / Trim / Acabado</label><input id="car_version" placeholder="Ej. 2.0 TDI 150cv / Style / GT Line"></div>
      <div class="field"><label id="lbl-year">Año de Matriculación</label><input id="car_year" type="number" placeholder="Ej. 2019"></div>
      <div class="field"><label id="lbl-price">Precio Venta (€)</label><input id="price" type="number" placeholder="15000"></div>
      <div class="field"><label id="lbl-km">Kilometraje Declarado</label><input id="km" type="number" placeholder="125000"></div>
      <div class="field"><label id="lbl-vin">Matrícula / VIN</label><input id="vin_plate" placeholder="1234 ABC / WBA..."></div>
      <div class="field"><label id="lbl-repairs">Presupuesto Reparaciones Estimado (€)</label><input id="repair_cost" type="number" placeholder="Ej. 950"></div>
    </div>

    <div class="toolbar" style="margin-top: 15px;">
      <button class="action-btn primary" onclick="saveCarToDB()" id="btn-save-db">💾 GUARDAR EN BASE DE DATOS</button>
      <button class="action-btn secondary" onclick="clearForm()" id="btn-new-car">➕ NUEVA EVALUACIÓN</button>
    </div>
  </section>

  <section class="card">
    <h2 id="sec-db-list">2 · Registro de Vehículos Guardados (Base de Datos Local)</h2>
    <div class="db-table-wrapper">
      <table class="db-table">
        <thead>
          <tr>
            <th>ID</th>
            <th id="th-car">Vehículo</th>
            <th id="th-engine">Motor / Año</th>
            <th id="th-price">Precio</th>
            <th id="th-score">Puntuación</th>
            <th id="th-actions">Acciones</th>
          </tr>
        </thead>
        <tbody id="db-cars-list">
          <tr><td colspan="6" style="text-align: center; color: var(--muted);" id="txt-no-cars">Cargando base de datos...</td></tr>
        </tbody>
      </table>
    </div>
  </section>

  <section class="card">
    <h2 id="sec-ident">3 · Identificación y Kilometraje (Cruce de Fuentes)</h2>
    <div id="section-1"></div>
  </section>

  <section class="card">
    <h2 id="sec-docs">4 · Documentación y Situación Legal</h2>
    <div id="section-2"></div>
  </section>

  <section class="card">
    <h2 id="sec-flood">5 · Carrocería, Golpes, Corrosión y Verificación de Inundación</h2>
    <div id="section-3"></div>
  </section>

  <section class="card">
    <h2 id="sec-engine">6 · Motor y Sistema de Propulsión</h2>
    <div id="section-4"></div>
  </section>

  <section class="card">
    <h2 id="sec-trans">7 · Cambio, Embrague y Transmisión</h2>
    <div id="section-5"></div>
  </section>

  <section class="card">
    <h2 id="sec-chassis">8 · Suspensión, Dirección, Frenos y Neumáticos</h2>
    <div id="section-6"></div>
  </section>

  <section class="card">
    <h2 id="sec-elec">9 · Electricidad, Seguridad y Climatización</h2>
    <div id="section-7"></div>
  </section>

  <section class="card">
    <h2 id="sec-workshop">10 · Elevador + Diagnosis Independiente en Taller</h2>
    <div id="section-8"></div>
  </section>

  <section class="card">
    <h2 id="sec-drive">11 · Prueba de Conducción Dinámica</h2>
    <div id="section-9"></div>
  </section>

  <section class="card danger-zone">
    <h2 id="sec-stop">12 · Banderas Rojas y Señales para Detener la Compra</h2>
    <div id="section-10"></div>
  </section>

  <section class="card">
    <h2 id="sec-notes">Notas Finales y Estrategia de Negociación</h2>
    <textarea id="notes" style="min-height: 100px;" placeholder="Anota códigos de error OBD2, facturas verificadas y presupuesto de reparaciones..."></textarea>
    <div class="toolbar">
      <button class="action-btn primary" onclick="window.print()" id="btn-pdf">🖨️ EXPORTAR INFORME PDF</button>
      <button class="action-btn danger" onclick="resetAudit()" id="btn-reset">🗑 REINICIAR PRUEBAS ACTUALES</button>
    </div>
  </section>
</main>

<script src="js/app.js"></script>
</body>
</html>
EOF

# 5. Generar README.md con la información inicial de la búsqueda
cat << 'EOF' > README.md
# test-car-app

Aplicación de **Auditoría e Inspección Vehicular** con interfaz Cyberpunk / Dark UI, soporte bilingüe (ES/EN) y base de datos local en el navegador mediante IndexedDB.

---

## 🎯 Criterios de Búsqueda Predefinidos (Referencia de Compra)

Basado en el análisis de mercado del Toyota C-HR (1.8 125h Active/Advance) y alternativas equivalentes en Península:

| Parámetro | Criterio de Selección |
| :--- | :--- |
| **Presupuesto Máximo** | 16.000 € |
| **Kilometraje Máximo** | 125.000 km |
| **Años Objetivo** | 2017 – 2019 (2 años antes / 1 año entorno a 2018) |
| **Ubicación Exclusiva** | Península Ibérica (Excluidos: Las Palmas, Tenerife, Mallorca) |
| **Motorización Objetivo** | Híbrido Gasolina HEV / Etiqueta ECO |

### 🚘 Modelos de Referencia en Búsqueda

* **Toyota C-HR 1.8 125h Advance (2017)**: ~15.290 € - 15.990 € | 90k - 115k km.
* **Toyota C-HR 1.8 125h Active / Advance (2018)**: ~15.800 € - 16.000 € | 105k - 122k km.
* **Toyota C-HR 1.8 125h Advance (2019)**: ~15.990 € - 16.000 € | 103k - 118k km.

---

## 💻 Características de la Aplicación

- **Modularización**: Separación completa de estructura (`index.html`), estilos (`css/styles.css`) y lógica (`js/app.js`).
- **Checklist Interactivo**: Cálculo automático de índice de confianza (100 a 0) según la gravedad del fallo (Crítico / Grave).
- **Audio Context**: Efectos sonoros interactivos (Glitch de inicio, Fallo Crítico y Sirena Hazard si la puntuación llega a 0).
- **Persistencia Local**: Base de datos IndexedDB para guardar e inspeccionar múltiples vehículos.
- **Exportación**: Formato apto para exportar e imprimir informes en PDF.

---

## 🚀 Inicio Rápido

Abre el archivo `index.html` en un navegador web o utiliza la extensión **Live Server** de Visual Studio Code.
EOF

# 6. Inicialización del Repositorio Git
if [ ! -d ".git" ]; then
  git init
  echo "node_modules/" > .gitignore
  echo ".DS_Store" >> .gitignore
fi

git add .
git commit -m "feat: modularize test-car-app with HTML5, CSS3, JS and initial README"

# Eliminar el archivo monolítico previo si aún existe
if [ -f "scoring-car-sales.html" ]; then
  rm "scoring-car-sales.html"
fi

echo "✅ Proceso completado con éxito. Tu proyecto está listo en 'test-car-app'."