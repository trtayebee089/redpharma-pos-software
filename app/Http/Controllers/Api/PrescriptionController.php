<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Storage;
use thiagoalessio\TesseractOCR\TesseractOCR;

class PrescriptionController extends Controller
{
    public function process(Request $request)
    {
        $request->validate([
            'prescription' => 'required|image|mimes:jpeg,png,jpg|max:4096'
        ]);

        // Save file
        $path = $request->file('prescription')->store('prescriptions', 'public');
        $filePath = Storage::path($path);

        // Run OCR
        $ocrText = (new TesseractOCR($filePath))
            ->lang('eng')
            ->run();

        // 🔹 Extract medicine names from OCR text
        $medicines = $this->extractMedicines($ocrText);

        return response()->json([
            'success' => true,
            'text' => $ocrText,
            'medicines' => $medicines
        ]);
    }

    private function extractMedicines($text)
    {
        $list = [];

        if (stripos($text, 'Paracetamol') !== false) {
            $list[] = ['id' => 1, 'name' => 'Paracetamol 500mg', 'price' => 50];
        }
        if (stripos($text, 'Amoxicillin') !== false) {
            $list[] = ['id' => 2, 'name' => 'Amoxicillin 250mg', 'price' => 100];
        }

        return $list;
    }
}
