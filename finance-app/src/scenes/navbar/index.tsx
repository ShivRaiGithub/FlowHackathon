import { useState } from "react";
import { Link } from "react-router-dom";
import { Box, Typography, useTheme } from "@mui/material";
import FlexBetween from "@/components/FlexBetween";

type Props = {};

const Navbar = (props: Props) => {
  const { palette } = useTheme();
  const [selected, setSelected] = useState("dashboard");

  return (
    <FlexBetween mb="0.25rem" p="0.5rem 0rem" color={palette.grey[100]}>
      <FlexBetween gap="2rem">
        {/* Dashboard Link */}
        <Box>
          <Link
            to="/dashboard"
            onClick={() => setSelected("dashboard")}
            style={{
              textDecoration: "none",
              color: selected === "dashboard" ? palette.grey[100] : palette.grey[400],
            }}
          >
            <Box
              sx={{
                "&:hover": { color: palette.secondary[100] },
                transition: "color 0.2s ease-in-out",
              }}
            >
              Dashboard
            </Box>
          </Link>
        </Box>

        {/* Log Transaction Link */}
        <Box>
          <Link
            to="/logTransaction"
            onClick={() => setSelected("logTransaction")}
            style={{
              textDecoration: "none",
              color: selected === "logTransaction" ? palette.grey[100] : palette.grey[400],
            }}
          >
            <Box
              sx={{
                "&:hover": { color: palette.secondary[100] },
                transition: "color 0.2s ease-in-out",
              }}
            >
              Log Transaction
            </Box>
          </Link>
        </Box>
      </FlexBetween>
    </FlexBetween>
  );
};

export default Navbar;
