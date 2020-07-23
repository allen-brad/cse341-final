const express = require('express');
const router = express.Router();


router.get('/', (req, res, next) =>{
    res.status(200).json({
        message: 'Events Fetched'
    });
});

router.post('/', (req, res, next) =>{
    const event = {
        name: req.body.name
    }
    res.status(200).json({
        message: 'Event created',
        createdEvent: event
    });
});

router.get('/:eventId', (req, res, next) =>{
    const eventId = req.params.eventId;
        res.status(200).json({
            message: 'Handling GET requets to /events/'+ eventId
        });
    
});

router.patch('/:eventId', (req, res, next) =>{
    const eventId = req.params.eventId;
    res.status(200).json({
        message: 'Handling PATCH requets to /events/' + eventId
    });
});

module.exports = router;