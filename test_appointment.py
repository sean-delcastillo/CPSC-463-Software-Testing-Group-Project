import odoo
from odoo.tests import TransactionCase, tagged
from odoo.exceptions import ValidationError

@tagged("-standard", "hospital")
class TestHospitalAppointment(TransactionCase):
    @classmethod
    def setUpClass(cls):
        super(TestHospitalAppointment, cls).setUpClass()
    
        cls.patient = cls.env['hospital.patient'].create({
            "name": "John Smith",
            "age": "20"
        })

        cls.doctor = cls.env['hospital.doctor'].create({
            "doctor_name": "Nick Doe",
            "age": "50"
        })


    def test_create_Appointment(self):
        appointmentInfo = {
            "patient_id" : self.patient.id,
            "doctor_id" : self.doctor.id,
            "name" : "test",
            "gender" : "male",
            "note" : "Testing the note",
            "date_appointment" : "2023-12-02",
            "date_checkup" : "2023-12-02 01:21:12"
        }

        newAppointment = self.env["hospital.appointment"].create(
            appointmentInfo
        )

        self.assertEqual(newAppointment.patient_id, self.patient)
        self.assertEqual(newAppointment.doctor_id, self.doctor)
        self.assertEqual(newAppointment.name, 'test')
        self.assertEqual(newAppointment.gender, self.patient.gender)
        self.assertEqual(newAppointment.note, "Testing the note")

    def test_confirm_Appointment(self):
        appointmentInfo = {
            "patient_id" : self.patient.id,
            "doctor_id" : self.doctor.id,
            "name" : "test",
            "gender" : "male",
            "note" : "Testing the note",
            "date_appointment" : "2023-12-02",
            "date_checkup" : "2023-12-02 01:21:12"
        }

        newAppointment = self.env["hospital.appointment"].create(
            appointmentInfo
        )

        newAppointment.action_confirm()

        self.assertEqual(newAppointment.state, "confirm")

    def test_complete_Appointment(self):
        appointmentInfo = {
            "patient_id" : self.patient.id,
            "doctor_id" : self.doctor.id,
            "name" : "test",
            "gender" : "male",
            "note" : "Testing the note",
            "date_appointment" : "2023-12-02",
            "date_checkup" : "2023-12-02 01:21:12"
        }

        newAppointment = self.env["hospital.appointment"].create(
            appointmentInfo
        )

        newAppointment.action_done()

        self.assertEqual(newAppointment.state, "done")      

    def test_draft_Appointment(self):
        appointmentInfo = {
            "patient_id" : self.patient.id,
            "doctor_id" : self.doctor.id,
            "name" : "test",
            "gender" : "male",
            "note" : "Testing the note",
            "date_appointment" : "2023-12-02",
            "date_checkup" : "2023-12-02 01:21:12"
        }

        newAppointment = self.env["hospital.appointment"].create(
            appointmentInfo
        )

        newAppointment.action_draft()

        self.assertEqual(newAppointment.state, "draft")  
    
    def test_cancel_Appointment(self):
        appointmentInfo = {
            "patient_id" : self.patient.id,
            "doctor_id" : self.doctor.id,
            "name" : "test",
            "gender" : "male",
            "note" : "Testing the note",
            "date_appointment" : "2023-12-02",
            "date_checkup" : "2023-12-02 01:21:12"
        }

        newAppointment = self.env["hospital.appointment"].create(
            appointmentInfo
        )

        newAppointment.action_cancel()

        self.assertEqual(newAppointment.state, "cancel")  

    def test_unlink_allowed(self):
        appointmentInfo = {
            "patient_id" : self.patient.id,
            "doctor_id" : self.doctor.id,
            "name" : "test",
            "gender" : "male",
            "note" : "Testing the note",
            "date_appointment" : "2023-12-02",
            "date_checkup" : "2023-12-02 01:21:12"
        }

        newAppointment = self.env["hospital.appointment"].create(
            appointmentInfo
        )

        newAppointment.unlink()
    
    def test_unlink_unallowed(self):
        appointmentInfo = {
            "patient_id" : self.patient.id,
            "doctor_id" : self.doctor.id,
            "name" : "test",
            "gender" : "male",
            "note" : "Testing the note",
            "date_appointment" : "2023-12-02",
            "date_checkup" : "2023-12-02 01:21:12",
            "state" : "done"
        }        

        #Unlink is not possible when state == done

        newAppointment = self.env["hospital.appointment"].create(
            appointmentInfo
        )

        try:
            newAppointment.unlink()
            self.fail("Unlink was possible when parameters were not met")
        except ValidationError as e:
            self.assertEqual(str(e), "You Cannot Delete %s as it is in Done State" % newAppointment.name)




        


