import odoo 
from odoo.tests import TransactionCase

@odoo.tests.tagged("-standard", "hospital")
class TestHospitalDoctor(TransactionCase):
    @classmethod
    def setUpClass(cls):
        super(TestHospitalDoctor, cls).setUpClass()

        cls.doctor = cls.env["hospital.doctor"].create({
            "name": "Carl Rennalds",
            "age": "31",
        })

    def test_default_gender(self):
        """
        Doctor's default gender value is male
        if no other gender value is chosen
        """

        self.assertEqual(self.doctor.gender, "male")

    def test_appointment_count(self):
        """
        Ensure we are not storing negative integers to a doctor
        """

        self.assertGreaterEqual(self.doctor.appointment_count, 0)
