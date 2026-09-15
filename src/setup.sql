-- Drop tables in reverse dependency order so FK constraints don't block the drops
DROP TABLE IF EXISTS project_category CASCADE;
DROP TABLE IF EXISTS project CASCADE;
DROP TABLE IF EXISTS category CASCADE;
DROP TABLE IF EXISTS organization CASCADE;

CREATE TABLE organization (
    organization_id SERIAL PRIMARY KEY,
    name            VARCHAR(150) NOT NULL,
    description     TEXT NOT NULL,
    contact_email   VARCHAR(255) NOT NULL,
    logo_filename   VARCHAR(255) NOT NULL
);

INSERT INTO organization (name, description, contact_email, logo_filename)
VALUES
(
    'BrightFuture Builders',
    'A nonprofit focused on improving community infrastructure through sustainable construction projects.',
    'info@brightfuturebuilders.org',
    'brightfuture-logo.png'
),
(
    'GreenHarvest Growers',
    'An urban farming collective promoting food sustainability and education in local neighborhoods.',
    'contact@greenharvest.org',
    'greenharvest-logo.png'
),
(
    'UnityServe Volunteers',
    'A volunteer coordination group supporting local charities and service initiatives.',
    'hello@unityserve.org',
    'unityserve-logo.png'
);

CREATE TABLE project (
    project_id      SERIAL PRIMARY KEY,
    organization_id INT NOT NULL,
    title           VARCHAR(200) NOT NULL,
    description     TEXT NOT NULL,
    location        VARCHAR(200) NOT NULL,
    date            DATE NOT NULL,
    CONSTRAINT fk_project_organization
        FOREIGN KEY (organization_id)
        REFERENCES organization(organization_id)
);

INSERT INTO project (organization_id, title, description, location, date) VALUES
(1, 'Community Center Renovation', 'Renovate the downtown community center roof and walls.', 'Downtown, Springfield', '2026-10-05'),
(1, 'Playground Build', 'Build a new playground for Elm Street Park.', 'Elm Street Park, Springfield', '2026-10-19'),
(1, 'School Library Repair', 'Fix broken shelving and repaint the school library.', 'Lincoln Elementary, Springfield', '2026-11-02'),
(1, 'Bridge Walkway Restoration', 'Restore the pedestrian walkway on River Bridge.', 'River Bridge, Springfield', '2026-11-16'),
(1, 'Senior Center Accessibility Ramp', 'Install accessibility ramp at the senior center.', 'Maple Ave Senior Center, Springfield', '2026-12-07'),
(2, 'Community Garden Planting Day', 'Plant spring vegetables at the neighborhood garden.', 'Riverside Community Garden, Springfield', '2026-10-10'),
(2, 'Urban Composting Workshop', 'Teach composting techniques to 30 families.', 'GreenHarvest Hub, Springfield', '2026-10-24'),
(2, 'School Garden Installation', 'Install raised-bed garden at Jefferson Middle School.', 'Jefferson Middle School, Springfield', '2026-11-07'),
(2, 'Farmers Market Volunteering', 'Help run the monthly sustainable produce market.', 'Central Plaza, Springfield', '2026-11-21'),
(2, 'Winter Greenhouse Build', 'Construct a small greenhouse for year-round growing.', 'Riverside Community Garden, Springfield', '2026-12-12'),
(3, 'Food Pantry Restock Drive', 'Collect and sort donated food items for the local pantry.', 'Unity Food Pantry, Springfield', '2026-10-08'),
(3, 'Holiday Gift Wrapping', 'Wrap gifts for 200 children in underprivileged families.', 'Unity Community Hall, Springfield', '2026-11-28'),
(3, 'Coat Drive Distribution', 'Distribute donated coats to homeless shelters.', 'Downtown Shelter, Springfield', '2026-12-01'),
(3, 'Senior Companion Visits', 'Visit isolated seniors for companionship and assistance.', 'Sunview Retirement Home, Springfield', '2026-12-14'),
(3, 'New Year Cleanup Campaign', 'Community street cleanup to start the new year fresh.', 'Main Street, Springfield', '2027-01-03');

CREATE TABLE category (
    category_id SERIAL PRIMARY KEY,
    name        VARCHAR(100) NOT NULL UNIQUE
);

INSERT INTO category (name) VALUES
('Environmental'),
('Education'),
('Community Service'),
('Health & Wellness'),
('Construction & Infrastructure');

CREATE TABLE project_category (
    project_id  INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (project_id, category_id),
    CONSTRAINT fk_pc_project
        FOREIGN KEY (project_id)
        REFERENCES project(project_id),
    CONSTRAINT fk_pc_category
        FOREIGN KEY (category_id)
        REFERENCES category(category_id)
);

INSERT INTO project_category (project_id, category_id) VALUES
(1,  5), (1,  3),
(2,  5), (2,  3),
(3,  5), (3,  2),
(4,  5),
(5,  5), (5,  4),
(6,  1), (6,  3),
(7,  1), (7,  2),
(8,  1), (8,  2),
(9,  1), (9,  3),
(10, 1),
(11, 3), (11, 4),
(12, 3),
(13, 3), (13, 4),
(14, 3), (14, 4),
(15, 1), (15, 3);
