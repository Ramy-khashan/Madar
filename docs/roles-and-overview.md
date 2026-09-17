# مدار — اختصار الأدوار والموجود حاليًا

Base: `https://api.madar.support/`

---

## الأدوار `role`

القيمة اللي بتتبعت في اللوجين/التسجيل هي دي بالظبط:

| في التطبيق | قيمة `role` | المعنى |
|---|---|---|
| فردي | `individual` | مشتري / مستخدم عادي |
| وسيط عقاري | `broker` | حساب بيزنس وسيط |
| مالك | `owner` | حساب بيزنس مالك |
| مدير مشروع | `project_manager` | مطور / إدارة مشاريع |

اللوجين بيبعت `role` حسب الاختيار.

---

## موجر وشاغر

### 1) العقارات الخاصة (شقة / فيلا / باقي الأنواع — مش جوه عمارة)

التأكيد بيبعت `PUT /properties/:propertyId` بالكائن المتداخل `tenancy` فقط.

**موجر**

```json
{
  "tenancy": {
    "status": "RENTED",
    "startDate": "2026-09-16T00:00:00.000Z",
    "endDate": "2026-09-30T00:00:00.000Z",
    "monthlyRent": "120000",
    "tenantName": "Test",
    "tenantPhone": "+201012212100"
  }
}
```

**شاغر**

```json
{
  "tenancy": {
    "status": "VACANT"
  }
}
```

العرض من `GET /properties/:id` → `data.tenancy`.

### 2) شقق العمارة

| العملية | الـ API |
|---|---|
| إضافة | `POST /building/:buildingId/apartments` |
| عرض | `GET /building/apartments/:propertyId` |
| تعديل موجر/شاغر | `PUT /building/apartments/:propertyId` |

الحقول المفلطحة: `status`, `tenantName`, `tenantPhone`, `monthlyRent`, `startDate`, `endDate`, `calendarType` + `livingRooms` عند الإضافة.

### 3) متاجر العمارة

نفس أسلوب الشقة:

| العملية | الـ API |
|---|---|
| إضافة | `POST /building/:buildingId/shops` |
| عرض | `GET /building/shops/:propertyId` |
| تعديل موجر/شاغر | `PUT /building/shops/:propertyId` |

المصاريف لنفس الوحدة: `POST /owner/property-expense`

---

## عقاراتي والنشر

- تاج الحالة من `publicationRequestStatus`:
  - `APPROVED` → منشور (أخضر)
  - `PENDING` → قيد الانتظار (أصفر)
  - غير كده → مرفوض (أحمر)
- نشر إعلان (مالك أو وسيط): `PATCH /properties/publish/:propertyId`  
  Body: `adLicenseNumber` + `falLicenseNumber`
- إرسال لوسيط بعد الإضافة: بيروح على صفحة الوسطاء  
  ثم `POST /properties/send-to-broker/`

---

## تقارير مالية

| العملية | الـ API |
|---|---|
| نظرة عامة | `GET /dashboard/overview` |
| إيرادات | `GET /dashboard/revenues` |
| مصروفات | `GET /dashboard/expenses` |
| إضافة دخل آخر | `POST /dashboard/other-income` |
| حذف دخل آخر | `DELETE /dashboard/other-income/:id` |
| أرباح وخسائر | `GET /dashboard/profit-loss` |
| أداء | `GET /dashboard/performance-reports` |

---

## باقي المختصر

- إنشاء عقار: `POST /properties` (multipart)
- ملف العقار: `GET/PUT/DELETE /properties/:id`
- خريطة: `GET /properties/map`
- عقاراتي: `GET /properties/my-properties`
- وسطاء: `GET /auth/brokers`
- عقود: `GET /contracts` + موافقة/رفض للوسيط
- مفضلة: `/saved-properties`
- دردشة: `/chat/...`
- تقييم ذكي: `/evaluations/smart-suggestion`
- مشاريع: `/projects` (مدير المشروع)
