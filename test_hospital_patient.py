import odoo 
from odoo.tests import TransactionCase

@odoo.tests.tagged("-standard", "hospital")
class TestHospitalPatient(TransactionCase):
    @classmethod
    def setUpClass(cls):
        super(TestHospitalPatient, cls).setUpClass()

        cls.patient = cls.env["hospital.patient"].create({
            "name": "John Smith",
        })

    def test_default_gender(self):
        """
        Patient's default gender should be "male"
        """
        self.assertEqual(self.patient.gender, "male")

    def test_default_reference(self):
        """
        Patient's reference field should be generated
        """
        self.assertIsNotNone(self.patient.reference)
