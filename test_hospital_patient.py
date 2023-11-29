import odoo 
from odoo.tests import TransactionCase

# tag to isolate test fixture when starting Odoo "--test-tags hospital"
@odoo.tests.tagged("-standard", "hospital")
class TestHospitalPatient(TransactionCase):
    @classmethod
    def setUpClass(cls):
        super(TestHospitalPatient, cls).setUpClass()

        # creating patient record for use in all fixture testcases
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
