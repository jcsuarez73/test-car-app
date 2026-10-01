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
